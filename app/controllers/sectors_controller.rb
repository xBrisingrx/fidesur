class SectorsController < ApplicationController
  before_action :set_sector, only: %i[ show edit update destroy ]

  # GET /sectors or /sectors.json
  def index
    @sectors = Sector.where(active: true)
    Sale.all.each do |sale|
      sale.calculate_total_paid
    end
  end

  # GET /sectors/1 or /sectors/1.json
  def show
  end

  # GET /sectors/new
  def new
    @title_modal = "Nuevo sector"
    @sector = Sector.new
  end

  # GET /sectors/1/edit
  def edit
    @title_modal = "Editar sector"
  end

  # POST /sectors or /sectors.json
  def create
    @sector = Sector.new(sector_params)

    respond_to do |format|
      if @sector.save
        # format.html { redirect_to @sector, notice: "Sector was successfully created." }
        format.json { render json: { status: 'success', msg: 'Nuevo sector registrado' } , status: :created }
      else
        # format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sectors/1 or /sectors/1.json
  def update
    respond_to do |format|
      if @sector.update(sector_params)
        # format.html { redirect_to @sector, notice: "Sector was successfully updated." }
        format.json { render json: { status: 'success', msg: 'Datos del sector modificados' } , status: :ok }
      else
        # format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sectors/1 or /sectors/1.json
  def destroy
    @sector.destroy
    respond_to do |format|
      format.html { redirect_to sectors_url, notice: "Sector was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @sector = Sector.find(params[:sector][:id])
    if @sector.update(active:false)
      render json: { status: 'success', msg: 'Sector eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sector
      @sector = Sector.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sector_params
      params.require(:sector).permit(:name, :size, :active)
    end
end
