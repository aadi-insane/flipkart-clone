class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :unit_price, :total_price, presence: true

  def self.ransackable_attributes(auth_object = nil)
    @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
  end

  def self.ransackable_associations(auth_object = nil)
    # byebug
    ["order", "product"]
  end

end
