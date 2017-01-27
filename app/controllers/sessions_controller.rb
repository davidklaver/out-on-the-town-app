class SessionsController < ApplicationController
	def new
    # if current_user
    #   p "*" * 50
    #   p current_user.id
    #   p "*" * 50
    # end
    render 'new.html.erb'
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # flash[:success] = 'Successfully logged in!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    # flash[:success] = 'Successfully logged out!'
    redirect_to '/'
  end
end
