Facter.add(:datacenter) do

  setcode do

    network_card = Facter.value(:ipaddress_eth1) || Facter.value(:ipaddress_enp0s8) || Facter.value(:ipaddress_eth0) || Facter.value(:ipaddress)

    case network_card

      when /^172.21.(\d+).(\d+)$/
        environment = 'prod-china'

      when /^172.(25|28).(\d+).(\d+)$/
        environment = 'prod-usa'

      when /^172.26.(\d+).(\d+)$/
        environment = 'prod-uk'

      when /^192.168.26.(\d+)$/
        environment = 'prod-uk'

      when /^172.27.(\d+).(\d+)$/
        environment = 'prod-asia'

      when /^172.(29|31).(\d+).(\d+)$/
        environment = 'preprod'

      when /^10.(167|168|169).(\d+).(\d+)$/
        environment = 'ci'

      when /^172.16.(\d+).(\d+)$/
        environment = 'vagrant'

      else
        environment = 'unknown'

    end

    environment

  end
end
