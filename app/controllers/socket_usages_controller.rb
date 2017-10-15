class SocketUsagesController < ApplicationController
  before_action :set_socket_usage, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /socket_usages
  # GET /socket_usages.json
  def index
    if current_user.is_admin
      @socket_usages = SocketUsage.all
    else
      @socket_usages = current_user.socket_usages.all  
    end
  end

  # GET /socket_usages/1
  # GET /socket_usages/1.json
  def show
    #TODO correct_user()
  end

  # GET /socket_usages/new
  def new
    @socket_usage = SocketUsage.new
  end

  # GET /socket_usages/1/edit
  def edit
  end

  # POST /socket_usages
  # POST /socket_usages.json
  def create
    @socket_usage = SocketUsage.new(socket_usage_params)

    respond_to do |format|
      if @socket_usage.save
        format.html { redirect_to @socket_usage, notice: 'Socket usage was successfully created.' }
        format.json { render :show, status: :created, location: @socket_usage }
      else
        format.html { render :new }
        format.json { render json: @socket_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socket_usages/1
  # PATCH/PUT /socket_usages/1.json
  def update
    respond_to do |format|
      if @socket_usage.update(socket_usage_params)
        format.html { redirect_to @socket_usage, notice: 'Socket usage was successfully updated.' }
        format.json { render :show, status: :ok, location: @socket_usage }
      else
        format.html { render :edit }
        format.json { render json: @socket_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socket_usages/1
  # DELETE /socket_usages/1.json
  def destroy
    @socket_usage.destroy
    respond_to do |format|
      format.html { redirect_to socket_usages_url, notice: 'Socket usage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_socket_usage
      @socket_usage = SocketUsage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def socket_usage_params
      params.require(:socket_usage).permit(:user_id, :el_socket_id, :start_time, :end_time, :kWhs, :amount, :date)
    end
end
