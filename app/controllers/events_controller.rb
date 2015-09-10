class EventsController < ApplicationController
  # check if the user is logged in (e.g., for editing only her own information)
  before_filter :signed_in_user
  # check if the user is a chef
  #before_filter :correct_chef, only: :new

  respond_to :html, :js

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      flash[:success] = 'Event created!'
      redirect_to myevents_user_path(current_user)
    else
      render 'new'
    end
  end

  def show


    # get the event with id :id (got from the URL)
    @event = Event.find(params[:id])
    # get the information about the event owner
    @user = @event.user

    #@comment = current_user.comments.build if signed_in?
    #@cmm_items = current_user.cmm(@event).paginate(page: params[:page]) if signed_in?


    # get and paginate the comments associated to the given event
    @comments = @event.comments.paginate(page: params[:page])



  end

  def index
    @events = Event.paginate(page: params[:page])
  end

  def destroy
    # delete the event starting from its id
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html {redirect_to('/users/'+current_user.id.to_s)}
    end

  end




  #def participants
   # @title = 'Participants'
   # @user = User.find(params[:id])
   # @users = @user.followers.paginate(page: params[:page])
   # render 'show_follow'
 # end



 # private
 # def correct_chef
    # is the user a chef?
 #   @user = User.find(params[:id])
 #  @category = @user.category

    # if not, redirect to the home page
 #   if !@category.eql?('Chef')
 #    redirect_to user_events_path
 #  end
 # end



end
