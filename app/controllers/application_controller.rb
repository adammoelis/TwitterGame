class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_account, :default_accounts

  def current_account
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]
  end

  def default_accounts
    [User.find_by(name: session[:republican_default]), User.find_by(name: session[:democrat_default]), User.find_by(name: session[:jerseyshore_default])]
  end
end
