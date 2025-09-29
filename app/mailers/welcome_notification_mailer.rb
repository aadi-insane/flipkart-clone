class WelcomeNotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_notification_mailer.create_notification.subject
  #
  def create_notification(object)
    @object = object
    # @object_count = object.class.count

    mail(to: @object.email, subject: 'Welcome to Flipkart Clone!')
  end

  def update_notification(object)
    @object = object
    mail(to: @object.email, subject: 'Flipkart Clone profile updated!')
  end
end
