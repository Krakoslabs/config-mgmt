# role facter

# * This fact gives you the applied role of the current node.
#   However it changes the puppet class names , changing the "::" for a dot
# * example:
#   role named role::products::veerp::veerp_web wil be retrieved as
#   role => role.products.veerp.veerp_web
#

require 'facter'
begin
  Facter.hostname
  Facter.fqdn
rescue
  Facter.loadfacts()
end

hostname      = Facter.value(:hostname)
fqdn          = Facter.value(:fqdn)
os            = Facter.value(:osfamily)
puppetversion = Facter.value(:puppetversion)

if puppetversion.to_i >= 4 then
  if os.casecmp('windows') == 0 then
    classes_txt = "C:\\ProgramData\\PuppetLabs\\puppet\\cache\\state\\classes.txt"
  else
    classes_txt = "/opt/puppetlabs/puppet/cache/state/classes.txt"
  end
else
  if os.casecmp('windows') == 0 then
    classes_txt = "C:\\ProgramData\\PuppetLabs\\puppet\\var\\state\\classes.txt"
  else
    classes_txt = "/var/lib/puppet/state/classes.txt"
  end
end

if File.exists?(classes_txt) then
  f = File.new(classes_txt)
  classes = Array.new()
  f.readlines.each do |line|
    line = line.chomp.to_s
    line = line.sub(" ","_")
    classes.push(line)
  end

  classes.delete("settings")
  classes.delete("#{hostname}")
  classes.delete("#{fqdn}")
  role_list = classes.join(",")
  role = role_list[/(role)[^,]*/]

  Facter.add(:role) do
    if ! role.to_s.empty? then
      role.gsub!("::", ".")
    end

    setcode do
      role
    end
  end
end
