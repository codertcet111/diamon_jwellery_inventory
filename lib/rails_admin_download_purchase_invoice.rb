require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class DownloadPurchaseInvoice < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :member do
          true
        end
        register_instance_option :controller do
          Proc.new do
            puts "****"*10
            request.format = :pdf
            respond_to  do |format|
              format.pdf do
                pdf = render_to_string :pdf => "Purchase_Invocie#{@object.id}",
                             layout: 'pdf.html.erb',
                             template: 'download_purchase_invoice.pdf.slim',
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
      end
    end
  end
end