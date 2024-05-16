require 'facter'

Facter.add(:host_number) do
  setcode do
    host_number = 0
    datacenter = Facter.value(:datacenter)
    hostname = Facter.value(:hostname)

    if datacenter == 'vagrant'
      host_number = hostname[-1].to_i
    else
      host_number = hostname[-2..-1].to_i
    end

    host_number
  end

end
