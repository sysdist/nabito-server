# == Schema Information
#
# Table name: el_sockets
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  code          :string
#  url           :string
#  address       :string
#  gps_lat       :float
#  gps_lng       :float
#  voltage       :integer
#  i_limit       :integer
#  price_per_kWh :float
#  in_use        :boolean
#  current_user  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  frequency     :integer
#  mqtt_id       :string
#

class ElSocketsController < ApplicationController
  before_action :set_el_socket, only: [:show, :edit, :update, :destroy, :switch_on, :switch_off]
  before_action :authenticate_user!

  # GET /el_sockets
  # GET /el_sockets.json
  def index
    @el_sockets = ElSocket.all
  end
  
  def switch_on
    return unless user_approved
    if correct_action("switch_on")
      @el_socket.switch_on(current_user)
    end 
    
    redirect_to @el_socket #, notice: 'El socket was successfully created.' 
  end
  
  def switch_off
    return unless user_approved
    if correct_action("switch_off")
      @el_socket.switch_off(current_user)  
    end 
    redirect_to @el_socket 
  end
  
  # GET /el_sockets/1
  # GET /el_sockets/1.json
  def show
  end

  # GET /el_sockets/new
  def new
    @el_socket = ElSocket.new
  end

  # GET /el_sockets/1/edit
  def edit
  end

  # POST /el_sockets
  # POST /el_sockets.json
  def create
    @el_socket = ElSocket.new(el_socket_params)

    respond_to do |format|
      if @el_socket.save
        format.html { redirect_to @el_socket, notice: 'El socket was successfully created.' }
        format.json { render :show, status: :created, location: @el_socket }
      else
        format.html { render :new }
        format.json { render json: @el_socket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /el_sockets/1
  # PATCH/PUT /el_sockets/1.json
  def update
    respond_to do |format|
      if @el_socket.update(el_socket_params)
        format.html { redirect_to @el_socket, notice: 'El socket was successfully updated.' }
        format.json { render :show, status: :ok, location: @el_socket }
      else
        format.html { render :edit }
        format.json { render json: @el_socket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /el_sockets/1
  # DELETE /el_sockets/1.json
  def destroy
    @el_socket.destroy
    respond_to do |format|
      format.html { redirect_to el_sockets_url, notice: 'El socket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_el_socket
      @el_socket = ElSocket.find(params[:id])
    end
    
    def correct_action(action)
      if action == "switch_on"
        if @el_socket.in_use
          if @el_socket.current_user == current_user.id
            flash[:notice] = "Socket already switched on"
            return false
          else
            flash[:notice] = "Socket currently used by a different user"
            return false
          end  
        else
          flash[:notice] = "Socket switched on"
          return true
        end
      end
      if action == "switch_off"
        if @el_socket.in_use
          if @el_socket.current_user == current_user.id
            flash[:notice] = "Socket switched off"
            return true
          else
            flash[:notice] = "Socket currently used by a different user"
            return false
          end  
        else
          flash[:notice] = "Socket is already off"
          return false
        end
      end
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def el_socket_params
      params.require(:el_socket).permit(:user_id, :code, :url, :address, :gps_lat, :gps_lng, :voltage, :i_limit, :price_per_kWh, :current_user, :mqtt_id, :status)
    end
end
