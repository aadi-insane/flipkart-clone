class Cart < ApplicationRecord
  # belongs_to :user
  belongs_to :customer, class_name: 'User', foreign_key: 'user_id'
  has_many :cart_items, -> { order(created_at: :desc) }, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
  end

  def self.ransackable_associations(auth_object = nil)
    # byebug
    ["cart_items", "customer"]
  end

  def empty!
    cart_items.destroy_all
  end

end
