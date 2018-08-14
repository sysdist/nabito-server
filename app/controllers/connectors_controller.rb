class ConnectorsController < ApplicationController
  before_action :set_connector, only: [:show, :edit, :update, :destroy, :switch_on, :switch_off, :token]
  before_action :authenticate_user!, except: :token
  before_action :user_approved, except: :token
  protect_from_forgery only: :token


  # GET /connectors
  # GET /connectors.json
  def index
    @connectors = Connector.all
  end
  
  def token
    tag_uid = params[:tag_uid]
    #TODO: security concern: tag_token = params[:tag_token]
    if !tag_uid or !Socket.ip_address_list.select(&:ipv4?).map(&:ip_address).include?(request.remote_ip) 
      head :unauthorized and return
    end 
    
    tag = Tag.find_by_uid(tag_uid)
    if !tag 
      head :unauthorized and return
    end
    
    current_user = tag.user
    
    if @connector.in_use 
      @connector.switch_off(current_user,tag.id)
    else
      @connector.switch_on(current_user,tag.id)
    end
    render json: @connector.status
  end

  
  def switch_on
    return unless user_approved
    if correct_action("switch_on")
      @connector.switch_on(current_user)
    end 
    
    redirect_to @connector #, notice: 'El socket was successfully created.' 
  end
  
  def switch_off
    return unless user_approved
    if correct_action("switch_off")
      @connector.switch_off(current_user)  
    end 
    redirect_to @connector 
  end

  # GET /connectors/1
  # GET /connectors/1.json
  def show
  end

  # GET /connectors/new
  def new
    @connector = Connector.new
  end

  # GET /connectors/1/edit
  def edit
  end

  # POST /connectors
  # POST /connectors.json
  def create
    @connector = Connector.new(connector_params)

    respond_to do |format|
      if @connector.save
        format.html { redirect_to @connector, notice: 'Connector was successfully created.' }
        format.json { render :show, status: :created, location: @connector }
      else
        format.html { render :new }
        format.json { render json: @connector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /connectors/1
  # PATCH/PUT /connectors/1.json
  def update
    respond_to do |format|
      if @connector.update(connector_params)
        format.html { redirect_to @connector, notice: 'Connector was successfully updated.' }
        format.json { render :show, status: :ok, location: @connector }
      else
        format.html { render :edit }
        format.json { render json: @connector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connectors/1
  # DELETE /connectors/1.json
  def destroy
    @connector.destroy
    respond_to do |format|
      format.html { redirect_to connectors_url, notice: 'Connector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connector
      @connector = Connector.find(params[:id])
    end
    
    def correct_action(action)
      if action == "switch_on"
        if @connector.in_use
          if @connector.current_user == current_user.id
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
        if @connector.in_use
          if @connector.current_user == current_user.id
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
    def connector_params
      params.require(:connector).permit(:box_id, :aws_conn_id, :code, :url, :power, :voltage, :i_max, :price_per_kWh, :current_user, :frequency, :status, :tag_uid, :tag_token)
    end
end
