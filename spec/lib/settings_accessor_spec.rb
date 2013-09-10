require 'settings_accessor'
require 'byebug'

describe SettingsAccessor do
  describe 'kochiku_protocol' do
    it 'returns https when use_https is truthy' do
      configatron.kochiku_protocol = "https"
      expect(configatron.kochiku_protocol).to eq("https")
    end

    it 'returns https when use_https is false' do
      configatron.kochiku_protocol = "http"
      expect(configatron.kochiku_protocol).to eq("http")
    end

    it 'returns https when use_https is not present' do
      configatron.kochiku_protocol = "more cowbell"
      expect(configatron.kochiku_protocol).to eq("http")
    end
  end

  it "can list git servers" do
    expect(SettingsAccessor.git_servers.keys).
      to match_array(%w{stash.example.com github.com github-enterprise.example.com})
    expect(SettingsAccessor.git_servers['stash.example.com'].type). to eq('stash')
    expect(SettingsAccessor.git_servers['stash.example.com'].username). to eq('robot')
    expect(SettingsAccessor.git_servers['stash.example.com'].password_file). to eq('/secrets/stash')

    expect(SettingsAccessor.git_servers['github-enterprise.example.com'].mirror).
      to eq('git://git-mirror.example.com/')
  end

  it "can look up git servers" do
    settings = {"git_servers" => {"stash.example.com" => {"type" => "stash"}, "github.com" => {"type" => "github"}}}
    expect(SettingsAccessor.git_server('git@stash.example.com:square/kochiku.git').type).to eq('stash')
    expect(SettingsAccessor.git_server('https://github.com/square/kochiku.git').type).to eq('github')
    expect(SettingsAccessor.git_server('https://foobar.com/square/kochiku.git')).to eq(nil)
  end

  it "can also give me the host which matched" do
    settings = {"git_servers" => {"github.com" => {"type" => "github"}}}
    expect(SettingsAccessor.git_server('https://github.com/square/kochiku.git').host).to eq('github.com')
  end

  it "still works if git_servers is not in the config file" do
    settings = SettingsAccessor.new("another_setting:\n")
    expect(settings.git_server('https://github.com/square/kochiku.git')).to eq(nil)
  end

  it "still works if a host is listed without any data" do
    settings = {"git_servers" => {"git.example.com" => nil}}
    expect(SettingsAccessor.git_server('git@git.example.com:square/kochiku.git').type).to eq(nil)
  end

  it 'respects relative paths for stash password file' do
    settings = {"git_servers" => {"stash.example.com" => {"password_file" => "secrets/stash"}}}
    expect(SettingsAccessor.git_servers['stash.example.com'].password_file).
      to match(%r{/.*/secrets/stash\Z})
  end
end
