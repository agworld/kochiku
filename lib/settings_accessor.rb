require 'active_support/core_ext/hash/indifferent_access'
require 'server_settings'
require 'configatron'

class SettingsAccessor

  def self.git_servers
    @git_servers ||= begin
      raw_servers = configatron.git_servers.with_indifferent_access
      if raw_servers
        raw_servers.each_with_object({}) do |(host, settings_for_server), result|
          result[host] = ServerSettings.new(settings_for_server, host)
        end
      else
        {}
      end
    end
  end

  def self.git_server(url)
    matching_host = git_servers.keys.detect { |host| url.include?(host) }
    matching_host ? git_servers[matching_host] : nil
  end

end
