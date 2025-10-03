class Product < ApplicationRecord
  paginates_per 18
  
  validates :name, :description, :price, :stock, :seller_id, presence: true
  validates_numericality_of :stock, only_integer: true
  validates :price, numericality: { greater_than_or_equal_to: 1.0, less_than: 1_000_000.0 }
  validate :stock_must_be_at_least_1

  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  has_many :cart_items
  has_many :order_items

  before_save :normalize_name

  enum availability: { in_stock: 'in_stock', out_of_stock: 'out_of_stock', backorder: 'backorder', pre_order: 'pre_order', limited_stock: 'limited_stock', discontinued: 'discontinued' }

  scope :in_stock, -> { where(availability: :in_stock) }
  scope :out_of_stock, -> { where(availability: :out_of_stock) }
  # scope :out_of_stock, -> { where(availability: 'out_of_stock') }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_brand, ->(brand) { where(brand: brand) }
  scope :by_color, ->(color) { where(color: color) }
  scope :by_size, ->(size) { where(size: size) }
  scope :price_between, ->(min, max) { where(price: min..max) }
  scope :recent, -> { order(created_at: :desc) }

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

    def normalize_name
      self.name = name.downcase.titleize
    end
end
