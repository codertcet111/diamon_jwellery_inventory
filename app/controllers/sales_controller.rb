class SalesController < ApplicationController
  def download_invoice
    @sales = Sales.find_by(id: params[:sales_id])
    respond_to  do |format|
      format.html
      format.pdf do
        pdf = render_to_string :pdf => "Sales_invocie_#{@sales.id}",
                         layout: 'pdf.html.erb',
                         template: 'invoice.pdf.slim',
                         header: { :right => '[page] of [topage]'},
                         margin: {top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0},
                         outline: {outline: true,
                                   outline_depth: 2}
        end
     end
	end
end