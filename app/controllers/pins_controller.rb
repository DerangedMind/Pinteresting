class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4);
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  # GET /pins/1/edit
  def edit
  end


  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was succesfully created.'
    else
      render action: 'new'
    end
  end
  
   # respond_to do |format|
    #  if @pin.save
     #   format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
      #  format.json { render :show, status: :created, location: @pin }
      #else
       # format.html { render :new }
        #format.json { render json: @pin.errors, status: :unprocessable_entity }
      #end
  #  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was succesfully updated.'
    else
      render action: 'edit'
    end
  end
    
#    respond_to do |format|
#      if @pin.update(pin_params)
#        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
#        format.json { render :show, status: :ok, location: @pin }
#      else
#        format.html { render :edit }
#        format.json { render json: @pin.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  def destroy
    @pin.destroy
    redirect_to pins_url, notice: 'That pin was thrown into the trash.'
  end

#    @pin.destroy
#    respond_to do |format|
#      format.html { redirect_to pins_url, notice: 'Pin was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image, :name)
    end
end

def correct_user
  @pin = current_user.pins.find_by(id: params[:id])
  redirect_to pins_path, notice: 'Not authorized to edit this pin' if @pin.nil?
end