class StockPcRangesController < ApplicationController
  before_action :set_stock_pc_range, only: %i[ show edit update destroy ]

  # GET /stock_pc_ranges or /stock_pc_ranges.json
  def index
    @stock_pc_ranges = StockPcRange.all
  end

  # GET /stock_pc_ranges/1 or /stock_pc_ranges/1.json
  def show
  end

  # GET /stock_pc_ranges/new
  def new
    @stock_pc_range = StockPcRange.new
  end

  # GET /stock_pc_ranges/1/edit
  def edit
  end

  # POST /stock_pc_ranges or /stock_pc_ranges.json
  def create
    @stock_pc_range = StockPcRange.new(stock_pc_range_params)

    respond_to do |format|
      if @stock_pc_range.save
        format.html { redirect_to @stock_pc_range, notice: "Stock pc range was successfully created." }
        format.json { render :show, status: :created, location: @stock_pc_range }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock_pc_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_pc_ranges/1 or /stock_pc_ranges/1.json
  def update
    respond_to do |format|
      if @stock_pc_range.update(stock_pc_range_params)
        format.html { redirect_to @stock_pc_range, notice: "Stock pc range was successfully updated." }
        format.json { render :show, status: :ok, location: @stock_pc_range }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock_pc_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_pc_ranges/1 or /stock_pc_ranges/1.json
  def destroy
    @stock_pc_range.destroy
    respond_to do |format|
      format.html { redirect_to stock_pc_ranges_url, notice: "Stock pc range was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_pc_range
      @stock_pc_range = StockPcRange.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_pc_range_params
      params.require(:stock_pc_range).permit(:name, :min_value, :max_value)
    end
end
