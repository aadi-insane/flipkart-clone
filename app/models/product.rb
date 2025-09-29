class Product < ApplicationRecord
  validates :name, :description, :price, :stock, :seller_id, presence: true
  validates_numericality_of :stock, only_integer: true
  validates :price, numericality: { greater_than_or_equal_to: 1.0, less_than: 1_000_000.0 }
  validate :stock_must_be_at_least_1

  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  has_many :cart_items
  has_many :order_items

  paginates_per 18

  def self.ransackable_attributes(auth_object = nil)
    @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
  end

  def self.ransackable_associations(auth_object = nil)
    # byebug
    ["cart_items", "order_items", "seller"]
  end

  private
    def stock_must_be_at_least_1
      if stock.blank? || stock < 1
        errors.add(:stock, "can not be less than 1.")
      end
    end
end
