class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN'], password: ENV['PASSWORD']


  def show
    @products = Product.count
    @categories = Category.count
  end
end
