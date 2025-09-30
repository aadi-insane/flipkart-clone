class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  enum role: { customer: 0, seller: 1, admin: 2 }

  has_many :products_as_seller, class_name: "Product", foreign_key: "seller_id"
  has_many :orders_as_customer, class_name: "Order", foreign_key: "customer_id"
  has_one :cart, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  # has_many :orders, dependent: :destroy

  after_create :create_user_cart
  before_save :normalize_name

  def self.ransackable_attributes(auth_object = nil)
    @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
  end

  def self.ransackable_associations(auth_object = nil)
    # byebug
    ["cart", "products_as_seller","orders_as_customer", "avatar_attachment", "avatar_blob"]
  end


  private
    def create_user_cart
      create_cart # Active Record provides create_association_name for has_one associations
    end

    def normalize_name
      self.name = name.downcase.titleize if self.name
    end

    # def self.ransackable_attributes(auth_object = nil)
    #   ["encrypted_password", "reset_password_token", "reset_password_token_sent_at", "remember_created_at"]
    # end

    
end
