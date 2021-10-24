class LedgerExpensesController < ApplicationController
  before_action :set_ledger_expense, only: %i[ show edit update destroy ]

  # GET /ledger_expenses or /ledger_expenses.json
  def index
    @ledger_expenses = LedgerExpense.all
  end

  # GET /ledger_expenses/1 or /ledger_expenses/1.json
  def show
  end

  # GET /ledger_expenses/new
  def new
    @ledger_expense = LedgerExpense.new
  end

  # GET /ledger_expenses/1/edit
  def edit
  end

  # POST /ledger_expenses or /ledger_expenses.json
  def create
    @ledger_expense = LedgerExpense.new(ledger_expense_params)

    respond_to do |format|
      if @ledger_expense.save
        format.html { redirect_to @ledger_expense, notice: "Ledger expense was successfully created." }
        format.json { render :show, status: :created, location: @ledger_expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ledger_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ledger_expenses/1 or /ledger_expenses/1.json
  def update
    respond_to do |format|
      if @ledger_expense.update(ledger_expense_params)
        format.html { redirect_to @ledger_expense, notice: "Ledger expense was successfully updated." }
        format.json { render :show, status: :ok, location: @ledger_expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ledger_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ledger_expenses/1 or /ledger_expenses/1.json
  def destroy
    @ledger_expense.destroy
    respond_to do |format|
      format.html { redirect_to ledger_expenses_url, notice: "Ledger expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ledger_expense
      @ledger_expense = LedgerExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ledger_expense_params
      params.require(:ledger_expense).permit(:title, :ledger_id, :amount, :notes, :payment_notes)
    end
end
