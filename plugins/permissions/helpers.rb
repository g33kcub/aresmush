module AresMUSH
  module Permissions
    def self.permissions
      Global.read_config("permissions", "permission_list")
    end
    def self.get_permission_desc(metadata_list, name)
      entry = metadata_list.select { |m| m['name'].upcase == name.upcase }.first
      entry ? entry['desc'] : nil
    end
    def self.get_permission_type(metadata_list, name)
      entry = metadata_list.select { |m| m['name'].upcase == name.upcase }.first
      entry ? entry['type'] : nil
    end
    def self.permissions_names
      permissions.map { |a| a['name'].titlecase }
    end
    def self.permissions_config(name)
      config = Permissions.permissions.find { |s| s["name"].upcase == name.upcase }
      if (!config)
        raise "Error in permission configuration -- permission #{name} not found."
      end
      config
    end
  end
end