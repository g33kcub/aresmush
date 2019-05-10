module AresMUSH
  module FS3Skills
    def self.can_manage_will?(actor)
      actor.has_permission?("manage_will")
    end
    def self.modify_will(char, amount)
      max_will = @char.get_max_will
      will = char.will + amount
      will = [max_will, will].min
      char.update(fs3_will: will)
    end
  end
end
