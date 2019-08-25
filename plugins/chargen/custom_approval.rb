module AresMUSH
  module Chargen
    def self.custom_approval(char)
      faction = char.group("Colony")
      fac = "#{faction}".downcase.tr(" ", "_")
      role = Role.find_by_name(fac)
      if (role)
        char.roles.add role
      end

      
    end
  end
end
