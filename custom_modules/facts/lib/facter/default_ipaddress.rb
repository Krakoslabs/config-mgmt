require 'facter'

Facter.add(:default_ipaddress) do

  setcode do

    datacenter = Facter.value(:datacenter)

    if datacenter == 'vagrant' then

      case Facter.value(:osfamily)
      when 'RedHat', 'CentOS'
        default_ipaddress = Facter.value(:ipaddress_eth1)
      when 'Debian', 'Ubuntu'
        default_ipaddress = Facter.value(:ipaddress_eth1)
      else
        default_ipaddress = Facter.value(:ipaddress)
      end
    else
      case Facter.value(:kernel)
      when 'windows'
        default_ipaddress = Facter.value(:ipaddress)
      else
        default_ipaddress = Facter.value(:ipaddress_eth0)
      end
    end

    default_ipaddress

  end

end
