class RelationshipsController < ApplicationController
  # a user must be signed in to follow/unfollow someone
  before_filter :signed_in_user

  # respond to the actions with html or javascript (see respond_with method)
  #respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # without javascript: redirect_to @user
    respond_to do |format|
      format.js {render inline: "location.reload();"}
    end

    #respond_with @user
    #redirect_to root_url
    # Rails will look for a add.js.erb file for responding to this action with ajax
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    # without javascript: redirect_to @user

    respond_to do |format|
      format.js {render inline: "location.reload();"}
    end

    #respond_with @user
    #redirect_to root_path
    # Rails will look for a add.js.erb file for responding to this action with ajax
  end

end