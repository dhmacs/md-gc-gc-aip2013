class AdminController < ApplicationController

  http_basic_authenticate_with :name => 'teacher', :password => 'secret'

  def index
  end
end
