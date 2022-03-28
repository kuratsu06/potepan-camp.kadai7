class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end
  
  def new
    @reservation = Reservation.new(reservation_params)
    @user = current_user.id
    @room = Room.find(params[:room_id])
    @stay = (@reservation.end_at.to_date) - (@reservation.start_at.to_date)
    @total = @stay * (@reservation.person).to_i * (@room.price).to_i
  end
  
  def create
    @user = User.find(params[:reservation][:user_id])
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      flash[:notice] = "Room was successfully created."
      redirect_to reservation_path(@reservation)
    else
      render 'rooms/show', flash: { error: @reservation.errors.full_messages }
    end
  end
  
  def show
    @reservation = Reservation.find(params[:id])
    @stay = (@reservation.end_at.to_date) - (@reservation.start_at.to_date)
    @total = @stay * (@reservation.person).to_i * (@reservation.room.price).to_i
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    
    if @reservation.update(reservation_params)
      redirect_to room_reservation_path
    else
      render 'edit'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    
    @reservation.destroy
    redirect_to room_reservations_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_at, :end_at, :person, :room_id).merge(user_id: current_user.id)
  end
end
