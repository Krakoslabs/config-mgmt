Facter.add(:default_directory) do

  setcode do

    os = Facter.value(:osfamily)

    if os.casecmp('windows') == 0 then
      default_directory = 'C:\\krk'
    else
      default_directory = '/var/appfire'
    end

    default_directory

  end
end
