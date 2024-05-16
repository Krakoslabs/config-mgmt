require 'facter'

Facter.add(:temp_directory) do
  setcode do
    temp_directory = nil

    os = Facter.value(:osfamily)

    # TODO: we need to refactor the project so we're using / instead of \ for Windows directories
    if os.casecmp('windows') == 0 then
      temp_directory = 'C:\Windows\Temp'
    else
      temp_directory = '/tmp'
    end

    temp_directory
  end

end
