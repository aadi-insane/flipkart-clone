# config/initializers/attachment_extensions.rb

module AttachmentExtensions
  extend ActiveSupport::Concern

  included do
    def self.ransackable_associations(*, **) = reflections.keys
    def self.ransackable_attributes(*, **) = attribute_names
  end
end

Rails.application.config.to_prepare do
  ActiveStorage::Attachment.include AttachmentExtensions
end