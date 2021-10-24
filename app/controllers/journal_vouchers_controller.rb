class JournalVouchersController < ApplicationController
  before_action :set_journal_voucher, only: %i[ show edit update destroy ]

  # GET /journal_vouchers or /journal_vouchers.json
  def index
    @journal_vouchers = JournalVoucher.all
  end

  # GET /journal_vouchers/1 or /journal_vouchers/1.json
  def show
  end

  # GET /journal_vouchers/new
  def new
    @journal_voucher = JournalVoucher.new
  end

  # GET /journal_vouchers/1/edit
  def edit
  end

  # POST /journal_vouchers or /journal_vouchers.json
  def create
    @journal_voucher = JournalVoucher.new(journal_voucher_params)

    respond_to do |format|
      if @journal_voucher.save
        format.html { redirect_to @journal_voucher, notice: "Journal voucher was successfully created." }
        format.json { render :show, status: :created, location: @journal_voucher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @journal_voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /journal_vouchers/1 or /journal_vouchers/1.json
  def update
    respond_to do |format|
      if @journal_voucher.update(journal_voucher_params)
        format.html { redirect_to @journal_voucher, notice: "Journal voucher was successfully updated." }
        format.json { render :show, status: :ok, location: @journal_voucher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @journal_voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journal_vouchers/1 or /journal_vouchers/1.json
  def destroy
    @journal_voucher.destroy
    respond_to do |format|
      format.html { redirect_to journal_vouchers_url, notice: "Journal voucher was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal_voucher
      @journal_voucher = JournalVoucher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def journal_voucher_params
      params.require(:journal_voucher).permit(:amount, :date, :notes)
    end
end
