class BrokersController < ApplicationController
  before_action :set_broker, only: [:show, :edit, :update, :destroy, :download_transactions]

  # GET /brokers
  # GET /brokers.json
  def index
    @brokers = Broker.all
  end

  # GET /brokers/1
  # GET /brokers/1.json
  def show
  end

  # GET /brokers/new
  def new
    @broker = Broker.new
  end

  # GET /brokers/1/edit
  def edit
  end

  # POST /brokers
  # POST /brokers.json
  def create
    @broker = Broker.new(broker_params)

    respond_to do |format|
      if @broker.save
        format.html { redirect_to @broker, notice: 'Broker was successfully created.' }
        format.json { render :show, status: :created, location: @broker }
      else
        format.html { render :new }
        format.json { render json: @broker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brokers/1
  # PATCH/PUT /brokers/1.json
  def update
    respond_to do |format|
      if @broker.update(broker_params)
        format.html { redirect_to @broker, notice: 'Broker was successfully updated.' }
        format.json { render :show, status: :ok, location: @broker }
      else
        format.html { render :edit }
        format.json { render json: @broker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brokers/1
  # DELETE /brokers/1.json
  def destroy
    @broker.destroy
    respond_to do |format|
      format.html { redirect_to brokers_url, notice: 'Broker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_transactions
    @company = CompanyDetail.first
    @ledger = @broker
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
    def set_broker
      @broker = Broker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def broker_params
      params.require(:broker).permit(:name, :mobile, :qbc, :address, :refrence_1, :refrence_2, :refrence_3, :gst_no, :pan_no, :adhaar_no, :mobile_2)
    end
end
