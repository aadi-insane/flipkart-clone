class AddressReminderMailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user && user.address.blank?

    UserMailer.address_reminder(user).deliver_later
  end
end