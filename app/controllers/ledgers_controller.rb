class LedgersController < ApplicationController
  before_action :set_ledger, only: %i[ show edit update destroy download_transactions ]

  # GET /ledgers or /ledgers.json
  def index
    @ledgers = Ledger.all
  end

  # GET /ledgers/1 or /ledgers/1.json
  def show
  end

  # GET /ledgers/new
  def new
    @ledger = Ledger.new
  end

  # GET /ledgers/1/edit
  def edit
  end

  # POST /ledgers or /ledgers.json
  def create
    @ledger = Ledger.new(ledger_params)

    respond_to do |format|
      if @ledger.save
        format.html { redirect_to @ledger, notice: "Ledger was successfully created." }
        format.json { render :show, status: :created, location: @ledger }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ledgers/1 or /ledgers/1.json
  def update
    respond_to do |format|
      if @ledger.update(ledger_params)
        format.html { redirect_to @ledger, notice: "Ledger was successfully updated." }
        format.json { render :show, status: :ok, location: @ledger }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ledgers/1 or /ledgers/1.json
  def destroy
    @ledger.destroy
    respond_to do |format|
      format.html { redirect_to ledgers_url, notice: "Ledger was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download_transactions
    @transactions = @ledger.transactions
    @debit_counts = @transactions.where.not(debit_amount: nil).count
    @credit_counts = @transactions.where.not(credit_amount: nil).count
    @total_debits = @transactions.sum(:debit_amount)
    @total_credits = @transactions.sum(:credit_amount)
    request.format = :pdf
    respond_to  do |format|
      format.html
      format.pdf do
        render template: 'ledgers/download_transactions.html.erb',
        pdf: "Ledger_Transactions_#{@ledger.name}"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ledger
      @ledger = Ledger.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ledger_params
      params.require(:ledger).permit(:name, :ledger_group_id)
    end
end
