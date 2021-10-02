class LedgerGroupsController < ApplicationController
  before_action :set_ledger_group, only: %i[ show edit update destroy ]

  # GET /ledger_groups or /ledger_groups.json
  def index
    @ledger_groups = LedgerGroup.all
  end

  # GET /ledger_groups/1 or /ledger_groups/1.json
  def show
  end

  # GET /ledger_groups/new
  def new
    @ledger_group = LedgerGroup.new
  end

  # GET /ledger_groups/1/edit
  def edit
  end

  # POST /ledger_groups or /ledger_groups.json
  def create
    @ledger_group = LedgerGroup.new(ledger_group_params)

    respond_to do |format|
      if @ledger_group.save
        format.html { redirect_to @ledger_group, notice: "Ledger group was successfully created." }
        format.json { render :show, status: :created, location: @ledger_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ledger_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ledger_groups/1 or /ledger_groups/1.json
  def update
    respond_to do |format|
      if @ledger_group.update(ledger_group_params)
        format.html { redirect_to @ledger_group, notice: "Ledger group was successfully updated." }
        format.json { render :show, status: :ok, location: @ledger_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ledger_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ledger_groups/1 or /ledger_groups/1.json
  def destroy
    @ledger_group.destroy
    respond_to do |format|
      format.html { redirect_to ledger_groups_url, notice: "Ledger group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ledger_group
      @ledger_group = LedgerGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ledger_group_params
      params.require(:ledger_group).permit(:name)
    end
end
