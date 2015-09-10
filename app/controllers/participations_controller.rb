class ParticipationsController < ApplicationController
  # a user must be signed in to participate/unparticipate for an event
  before_filter :signed_in_user

  # respond to the actions with html or javascript (see respond_with method)
  respond_to :html, :js

  def create
    @event = Event.find(params[:participation][:participated_id])
    current_user.participate!(@event)
    # without javascript: redirect_to @user
    respond_to do |format|
      format.js {render inline: "location.reload();"}
    end
    # Rails will look for a add.js.erb file for responding to this action with ajax
  end

  def destroy
    @event = Participation.find(params[:id]).participated
    current_user.unparticipate!(@event)
    # without javascript: redirect_to @user
    respond_to do |format|
      format.js {render inline: "location.reload();"}
    end
    # Rails will look for a add.js.erb file for responding to this action with ajax
  end


end