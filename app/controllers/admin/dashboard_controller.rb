class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  # http_basic_authenticate_with name: "foo", password: "bar"


  def show
    @products = Product.count
    @categories = Category.count
  end
end
