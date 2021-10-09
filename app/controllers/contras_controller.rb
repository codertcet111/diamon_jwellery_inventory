class ContrasController < ApplicationController
  before_action :set_contra, only: %i[ show edit update destroy ]

  # GET /contras or /contras.json
  def index
    @contras = Contra.all
  end

  # GET /contras/1 or /contras/1.json
  def show
  end

  # GET /contras/new
  def new
    @contra = Contra.new
  end

  # GET /contras/1/edit
  def edit
  end

  # POST /contras or /contras.json
  def create
    @contra = Contra.new(contra_params)

    respond_to do |format|
      if @contra.save
        format.html { redirect_to @contra, notice: "Contra was successfully created." }
        format.json { render :show, status: :created, location: @contra }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contras/1 or /contras/1.json
  def update
    respond_to do |format|
      if @contra.update(contra_params)
        format.html { redirect_to @contra, notice: "Contra was successfully updated." }
        format.json { render :show, status: :ok, location: @contra }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contras/1 or /contras/1.json
  def destroy
    @contra.destroy
    respond_to do |format|
      format.html { redirect_to contras_url, notice: "Contra was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contra
      @contra = Contra.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contra_params
      params.require(:contra).permit(:amount, :date, :notes)
    end
end
