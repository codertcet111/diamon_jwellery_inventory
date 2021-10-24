class EntryModulesController < ApplicationController
  before_action :set_entry_module, only: %i[ show edit update destroy ]

  # GET /entry_modules or /entry_modules.json
  def index
    @entry_modules = EntryModule.all
  end

  # GET /entry_modules/1 or /entry_modules/1.json
  def show
  end

  # GET /entry_modules/new
  def new
    @entry_module = EntryModule.new
  end

  # GET /entry_modules/1/edit
  def edit
  end

  # POST /entry_modules or /entry_modules.json
  def create
    @entry_module = EntryModule.new(entry_module_params)

    respond_to do |format|
      if @entry_module.save
        format.html { redirect_to @entry_module, notice: "Entry module was successfully created." }
        format.json { render :show, status: :created, location: @entry_module }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entry_modules/1 or /entry_modules/1.json
  def update
    respond_to do |format|
      if @entry_module.update(entry_module_params)
        format.html { redirect_to @entry_module, notice: "Entry module was successfully updated." }
        format.json { render :show, status: :ok, location: @entry_module }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entry_modules/1 or /entry_modules/1.json
  def destroy
    @entry_module.destroy
    respond_to do |format|
      format.html { redirect_to entry_modules_url, notice: "Entry module was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry_module
      @entry_module = EntryModule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_module_params
      params.require(:entry_module).permit(:total_debit, :total_credit, :narration)
    end
end
