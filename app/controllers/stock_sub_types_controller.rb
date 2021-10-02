class StockSubTypesController < ApplicationController
  before_action :set_stock_sub_type, only: %i[ show edit update destroy ]

  # GET /stock_sub_types or /stock_sub_types.json
  def index
    @stock_sub_types = StockSubType.all
  end

  # GET /stock_sub_types/1 or /stock_sub_types/1.json
  def show
  end

  # GET /stock_sub_types/new
  def new
    @stock_sub_type = StockSubType.new
  end

  # GET /stock_sub_types/1/edit
  def edit
  end

  # POST /stock_sub_types or /stock_sub_types.json
  def create
    @stock_sub_type = StockSubType.new(stock_sub_type_params)

    respond_to do |format|
      if @stock_sub_type.save
        format.html { redirect_to @stock_sub_type, notice: "Stock sub type was successfully created." }
        format.json { render :show, status: :created, location: @stock_sub_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock_sub_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_sub_types/1 or /stock_sub_types/1.json
  def update
    respond_to do |format|
      if @stock_sub_type.update(stock_sub_type_params)
        format.html { redirect_to @stock_sub_type, notice: "Stock sub type was successfully updated." }
        format.json { render :show, status: :ok, location: @stock_sub_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock_sub_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_sub_types/1 or /stock_sub_types/1.json
  def destroy
    @stock_sub_type.destroy
    respond_to do |format|
      format.html { redirect_to stock_sub_types_url, notice: "Stock sub type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_sub_type
      @stock_sub_type = StockSubType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_sub_type_params
      params.require(:stock_sub_type).permit(:name, :weight_unit, :stock_type_id)
    end
end
