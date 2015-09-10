class MailsController < ApplicationController
  # a user must be signed in to send a mail
  before_filter :signed_in_user

  # respond to the actions with html or javascript (see respond_with method)
  respond_to :html, :js

  def create
    @user = User.find(params[:mail][:receiver_id])
    @mex=(params[:mail][:message])

    begin
      @user.send!(@user, current_user, @mex)
    respond_to do |format|
      format.js {render inline: "location.reload();alert(\"Message sent!\");"}
    end
    rescue
      respond_to do |format|
        format.js {render inline: "location.reload();alert(\"Message can\'t be empty!\");"}
      end
    #flash[:success] = 'Message sent!'
    #redirect_to :back
    #else
    #flash[:danger] = 'ERROR: Title must be present and longer than 5 chars content must be present and not longer than 500 chars'
    #redirect_to :back
    end
  # Rails will look for a add.js.erb file for responding to this action with ajax
  end


  def destroy
    @mail = Mail.find params[:id]
    @mail.destroy
    respond_to do |format|
      format.js {render :js => "window.location = '/users/"+current_user.id.to_s+"/senders'; alert(\"Message deleted!\");"}
    end


  end




  def index
    @mails = Mail.paginate(page: params[:page])
  end

  #def destroy
   # @user = Relationship.find(params[:id]).followed
    #current_user.unfollow!(@user)
    # without javascript: redirect_to @user
    #respond_with @user
    # Rails will look for a add.js.erb file for responding to this action with ajax
  #end


  def show


    # get the event with id :id (got from the URL)
    @mail = Mail.find(params[:id])
    # get the information about the event owner

    #@comment = current_user.comments.build if signed_in?
    #@cmm_items = current_user.cmm(@event).paginate(page: params[:page]) if signed_in?




  end


#  private

 # def correct_user
    # does the user have a comment with the given id?
  #  @mail = current_user.mails.find_by_id(params[:id])
    # if not, redirect to the home page
   # redirect_to root_url if @mail.nil?
  # end
end