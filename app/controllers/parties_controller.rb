class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy, :download_transactions]

  # GET /parties
  # GET /parties.json
  def index
    @parties = Party.all
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(party_params)

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @party }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_transactions
    @company = CompanyDetail.first
    @ledger = @party
    @transactions = @ledger.transactions.where("transaction_date >= ? and transaction_date <= ?", params[:start_date].to_datetime, params[:end_date].to_datetime).order(:transaction_date)
    @debit_counts = @transactions.where.not(debit_amount: nil).count
    @credit_counts = @transactions.where.not(credit_amount: nil).count
    @total_debits = @transactions.sum(:debit_amount)
    @total_credits = @transactions.sum(:credit_amount)
    last_txn = @ledger.transactions.where('transaction_date < ?', params[:start_date].to_time).order(:transaction_date).last
    @initial_openning_balance = last_txn.present? ? last_txn.closing_balance : 0.0
    @final_closing_balance = @transactions.last.present? ? @transactions.last.closing_balance : @initial_openning_balance
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
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def party_params
      params.require(:party).permit(:name, :mobile, :qbc, :address, :refrence_1, :refrence_2, :refrence_3, :gst_no, :pan_no, :adhaar_no, :mobile_2)
    end
end
