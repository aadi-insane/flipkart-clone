class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"

  has_many :order_items, dependent: :destroy

  validates :customer_id, :status, :payment_option, :delivery_address, :total_amount, presence: true

  enum status: {
    recieved: 0, shipped: 1, dispatched: 2,
    out_for_delivery: 3, delivered: 4, cancelled: 5, returned: 6
  }

  enum payment_option: { cod: 0, emi: 1, upi: 2, card: 3 }

  accepts_nested_attributes_for :order_items

  scope :by_customer, ->(customer_id) { where(customer_id: customer_id) }
  scope :recent, -> { order(created_at: :desc) }
  scope :with_status, ->(status) { where(status: Order.statuses[status]) }
  scope :completed, -> { where(status: Order.statuses[:completed]) }
  scope :pending_or_paid, -> { where(status: [Order.statuses[:pending], Order.statuses[:paid]]) }


  def self.ransackable_attributes(auth_object = nil)
    @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
  end

  def self.ransackable_associations(auth_object = nil)
    # byebug
    ["order_items", "customer"]
  end

end
