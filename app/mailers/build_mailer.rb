class BuildMailer < ActionMailer::Base
  helper :application

  default :from => Proc.new { configatron.sender_email_address }

  def error_email(build_attempt, error_text = nil)
    @build_part = build_attempt.build_part
    @builder = build_attempt.builder
    @error_text = error_text
    mail :to => configatron.kochiku_notifications_email_address,
         :subject => "[kochiku] Build part errored on #{@builder}",
         :from => configatron.sender_email_address
  end

  def build_break_email(build)
    @build = build
    if @build.project.main?
      @emails = GitBlame.emails_since_last_green(@build)
      @git_changes = GitBlame.changes_since_last_green(@build)
    else
      @emails = GitBlame.emails_in_branch(@build)
      @git_changes = GitBlame.changes_in_branch(@build)
    end

    @failed_build_parts = @build.build_parts.failed_or_errored

    email_user, email_domain = configatron.sender_email_address.split('@')

    mail :to => @emails,
         :bdd => configatron.kochiku_notifications_email_address,
         :subject => "[kochiku] #{@build.project.name} build for branch #{@build.branch} failed",
         :from => "#{email_user}+#{@build.project.name.parameterize}@#{email_domain}"
  end
end
