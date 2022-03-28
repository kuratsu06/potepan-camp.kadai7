class UsersController < ApplicationController
  def index
    @rooms = Room.where(user_id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully updated."
      redirect_to edit_user_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    @user.destroy
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :image, :plofile)
  end
end