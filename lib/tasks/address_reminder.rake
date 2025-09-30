namespace :address_reminder do
  desc "Send reminder emails to users without an address"
  task send_emails: :environment do
    User.where(address: [nil, '']).find_each do |user|
      AddressReminderMailJob.perform_later(user.id)
    end
  end
end