class Admin::BaseController < ApplicationController
    http_basic_authenticate_with name: ENV['ADMIN'], password: ENV['PASSWORD']
end
