class UserMailer < ApplicationMailer

  def order_confirmation(order)
    @order = order[:order]
    @cart = order[:cart]
    mail(to: @order.email, subject: "Order Confirmation for Order ##{@order.id}")
  end

end
