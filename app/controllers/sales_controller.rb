class SalesController < ApplicationController
  before_action :set_purchase, only: [:download_sale_invoice]

  def download_sale_invoice
    request.format = :pdf
    respond_to  do |format|
      format.html
      format.pdf do
        render template: 'sales/download_sale_invoice.html.erb',
        pdf: "Sale_Invoice_#{@sale.id}"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @sale = Sale.find(params[:id])
    end
end