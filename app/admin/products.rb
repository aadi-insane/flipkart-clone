ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  # panel "All Products" do
  #   ul do
  #     Product.all.map do |product|
  #       li product.name
  #       li product.seller_id
  #       li product.stock
  #     end
  #   end
  # end
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :stock, :seller_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :stock, :seller_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column 
    id_column
    column :name
    column :price
    column :stock
    column :seller
    column :created_at, label: "Added On"
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      # Specify the max value for the price input explicitly
      f.input :price, input_html: { max: 999_999.99 }
      f.input :stock
      f.input :seller
    end
    f.actions
  end
  
end
