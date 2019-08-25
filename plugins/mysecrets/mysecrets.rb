$:.unshift File.dirname(__FILE__)

module AresMUSH
     module MySecrets

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("mysecrets", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "secrets"
        case cmd.switch
        when "set"
          return SetSecretsCmd
        when "preference"
          return SetSecretPrefCmd
        when "setplot"
          return SetSecretsPlotCmd
        when nil
          return SecretsCmd
        end
      end
      case cmd.root
      when "gmsecrets"
        case cmd.switch
        when "set"
          return SetGMSecretsCmd
        else
          return GMSecretsCmd
        end
    end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      nil
    end
  end
  end
end
