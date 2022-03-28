class RoomsController < ApplicationController
  def index
    @users = User.all
    @rooms = Room.all
  end
  
  def new
    @room = Room.new
    @user = current_user.id
  end
  
  def create
    @room = Room.new(room_params)

    if @room.save
      flash[:success] = "Room was successfully created."
      redirect_to rooms_path
    else
      render 'new'
    end
  end
  
  def show
    @room = Room.find(params[:id])

    @reservation = Reservation.new
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    
    if @room.update(room_params)
      flash[:success] = "Room was successfully updated."
      redirect_to room_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    
    @room.destroy
    redirect_to root_path
  end
  
  def seek
    @rooms = Room.seek(params[:address])
    @address = params[:address]
      render 'index'
  end
  
  def search
    @rooms = Room.search(params[:keyword])
    @keyword = params[:keyword]
      render 'index'
  end
  
  private
  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :image, :user_id)
  end
end