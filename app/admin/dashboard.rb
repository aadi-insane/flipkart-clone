# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: "Admin Dashboard" do

    columns do
      column do
        panel "Total Counts" do
          para "Users: #{User.count}"
          para "Products: #{Product.count}"
          para "Orders: #{Order.count}"
        end
      end

      column do
        panel "Sales This Week" do
          line_chart Order.group_by_day(:created_at).sum(:total_amount)
        end
      end
    end

    columns do
      column do
        panel "Top Products" do
          bar_chart Product.joins(:order_items)
                           .group(:name)
                           .sum("order_items.quantity")
        end
      end

      column do
        panel "Low Stock Products" do
          ul do
            Product.where("stock < ?", 10).each do |product|
              li "#{product.name} (#{product.stock} left)"
            end
          end
        end
      end
    end

  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end

# ActiveAdmin.register_page "Dashboard" do
#   menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

#   content title: "Admin Dashboard" do

#     columns do
#       column do
#         panel "Total Counts" do
#           para "Users: #{User.count}"
#           para "Products: #{Product.count}"
#           para "Orders: #{Order.count}"
#         end
#       end

#       column do
#         panel "Sales This Week" do
#           line_chart Order.group_by_day(:created_at, last: 7).sum(:total_amount), xtitle: "Date", ytitle: "Sales (₹)"
#         end
#       end
#     end

#     columns do
#       column do
#         panel "Top Selling Products" do
#           bar_chart Product.joins(:order_items)
#                            .group(:name)
#                            .sum("order_items.quantity")
#         end
#       end

#       column do
#         panel "Low Stock Products (< 10)" do
#           ul do
#             Product.where("stock < ?", 10).limit(10).each do |product|
#               li "#{product.name} (#{product.stock} left)"
#             end
#           end
#         end
#       end

#       # panel "Un-checked Out Carts with Total Price" do
#       # #   total_per_user = Cart.joins(cart_items: :product)
#       # #     .group('carts.user_id')
#       # #     .sum('products.price * cart_items.quantity')
#       #   total_per_user = CartItem.where(cart_id: Cart.joins(:cart_items).group(:id))

#       #   pie_chart total_per_user.transform_keys { |cart_id| CartItem.find(cart_id) }
#       # end

#     end

#     columns do
#       column do
#         panel "Monthly Sales" do
#           column_chart Order.group_by_month(:created_at, last: 6).sum(:total_amount), xtitle: "Month", ytitle: "Revenue ($)"
#         end
#       end

#       column do
#         panel "Orders by Status" do
#           pie_chart Order.group(:status).count.transform_keys { |k| Order.statuses.key(k) }
#         end
#       end

#       column do
#         panel "Items in Carts" do
#           cart_data = CartItem.group(:product_id).count
#           product_names = Product.where(id: cart_data.keys).pluck(:id, :name).to_h
#           named_data = cart_data.transform_keys { |id| product_names[id] || "Product #{id}" }
#           pie_chart named_data
#         end
#       end
#     end

#   end
# end
