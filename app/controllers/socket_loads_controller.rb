class SocketLoadsController < ApplicationController
  before_action :set_socket_load, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /socket_loads
  # GET /socket_loads.json
  def index
    @socket_loads = SocketLoad.all
  end

  # GET /socket_loads/1
  # GET /socket_loads/1.json
  def show
  end

  # GET /socket_loads/new
  def new
    @socket_load = SocketLoad.new
  end

  # GET /socket_loads/1/edit
  def edit
  end

  # POST /socket_loads
  # POST /socket_loads.json
  def create
    @socket_load = SocketLoad.new(socket_load_params)

    respond_to do |format|
      if @socket_load.save
        format.html { redirect_to @socket_load, notice: 'Socket load was successfully created.' }
        format.json { render :show, status: :created, location: @socket_load }
      else
        format.html { render :new }
        format.json { render json: @socket_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socket_loads/1
  # PATCH/PUT /socket_loads/1.json
  def update
    respond_to do |format|
      if @socket_load.update(socket_load_params)
        format.html { redirect_to @socket_load, notice: 'Socket load was successfully updated.' }
        format.json { render :show, status: :ok, location: @socket_load }
      else
        format.html { render :edit }
        format.json { render json: @socket_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socket_loads/1
  # DELETE /socket_loads/1.json
  def destroy
    @socket_load.destroy
    respond_to do |format|
      format.html { redirect_to socket_loads_url, notice: 'Socket load was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_socket_load
      @socket_load = SocketLoad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def socket_load_params
      params.require(:socket_load).permit(:el_socket_id, :i_current, :voltage, :power, :time)
    end
end
