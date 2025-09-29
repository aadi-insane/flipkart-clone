# Preview all emails at http://localhost:3000/rails/mailers/welcome_notification_mailer
class WelcomeNotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcome_notification_mailer/create_notification
  def create_notification
    WelcomeNotificationMailer.create_notification
  end

end
