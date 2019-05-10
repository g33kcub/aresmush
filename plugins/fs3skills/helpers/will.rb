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
    def self.do_regen_will(char)
      will = @char.will
      if @char.is_approved? && will > 0
        FS3Skills.modify_will(@char, -1)
        client.emit_ooc t('fs3magix.regen_will')
      end
  end
end
