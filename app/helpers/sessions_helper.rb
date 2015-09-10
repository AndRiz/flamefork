module SessionsHelper

  # Sign in method: store the remember token in a permanent cookie (it lasts for 20 years...)
  # and set the user performing the sign in as the current user
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    # self is mandatory to tell Rails that current_user is a method already defined and not a variable to be created
    self.current_user = user # equivalent to: self.current_user=(user)
  end

  # Set current user method: set the user performing the sign in as the current user
  #
  # user - The User to be used as current user in the session
  def current_user=(user)
    @current_user = user
  end

  # Get current user method: get the user corresponding to the remember token only if @current_user is undefined
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # Is the current user signed in?
  def signed_in?
    !current_user.nil?
  end

  # Sign out method: clear the current user instance variable and delete the corresponding cookie
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # Check if the given user is also the current user (for authorization purposes)
  #
  # user - The User to check the authorization for
  def current_user?(user)
    user == current_user
  end


  def correct_chef?(user)
    # is the user a chef?
    @user = user
    @category = @user.category
    @category.eql?('Chef')
  end



  # Redirect the user to the Sign in page if she is not logged in
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in" unless signed_in?
    # notice: "Please sign in" is the same of flash[:notice] = "Please sign in"
  end

end
