configatron.github_oath = ENV["GITHUB_TOKEN"]


# Email Settings

# Email address to use in the 'from' field for emails sent by Kochiku.
configatron.sender_email_address = ENV["SENDER_EMAIL_ADDRESS"]

# Email address where kochiku should send problems with the build system (for example, errors),
# as distinct from failures in a particular test (which go to the people who committed code).
configatron.kochiku_notifications_email_address = ENV["NOTIFICATIONS_EMAIL_ADDRESS"]

# Domain name to use in constructing generic addresses. For example noreply@example.com in git commits.
configatron.domain_name = ENV["DOMAIN"]

# Set to true if Kochiku is served over https
configatron.use_https = false

# Host name where Kochiku is serving web pages.
configatron.kochiku_host = ENV["KOCHIKU_HOST"]

# If you commit with hitch/git-pair, etc, set this in order to send email to each person in the pair.
# For example, github+joe+bob@example.com will turn into emails to joe@example.com and bob@example.com
# if git_pair_email_prefix is set to 'github'.
configatron.git_pair_email_prefix = ENV["KOCHIKU_HOST"]

# Mail server which will accept mail on port 25 (standard SMTP port). If you need to use another port,
# or other settings, you currently need to edit the kochiku source (config.action_mailer settings in
# config/environments/production.rb).
configatron.smtp_server = ENV["SMTP_SERVER"]

# List your git servers (at least for now, they need to be either github, github enterprise, or
# Atlassian Stash for things like constructing URLs to pages on those servers. Would be nice to
# just turn off the fancy features for a vanilla git server instead, but that isn't yet possible).
configatron.git_servers = { "github.com" => { "type" => "github" } }

# If you would like Kochiku to clone and fetch repositories from a git mirror
# define the repository and fill in the url to your mirror.
#  git.example.com:
#    mirror: 'git://git-mirror.example.com/'

# Example of Atlassian Stash integration.
#  configatron.git_servers.stash_example_com.type = "stash"
#  configatron.git_servers.stash_example_com.username = "kochiku-robot"
#  configatron.git_servers.stash_example_com.password_file = "config/secrets/kochiku-robot-password"