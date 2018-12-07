class UserMailer < ApplicationMailer

  def order_confirmation(order)
    @order = order[:order]
    @cart = order[:cart]
    mail(to: "andydlindsay@gmail.com", subject: "Order Confirmation for Order ##{@order.id}")
  end

end
