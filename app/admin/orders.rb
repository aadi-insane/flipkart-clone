ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :customer_id, :status, :delivery_address, :payment_option, :total_amount
  #
  # or
  #
  # permit_params do
  #   permitted = [:customer_id, :status, :delivery_address, :payment_option, :total_amount]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    selectable_column
    id_column
    column :customer
    column :status
    column :delivery_address
    column :payment_option
    column :total_amount
    column :created_at
    actions
  end

end
