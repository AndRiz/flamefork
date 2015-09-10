class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  require 'will_paginate/array'
  require 'will_paginate/active_record'

  respond_to :html, :js

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
  end

end
