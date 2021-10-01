RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  config.sidescroll = {num_frozen_columns: 0}
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Stock', 'SaleItem']
    end
    export
    bulk_delete
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.model 'Purchase' do
    show do
      include_all_fields
      field :payments do
        pretty_value do
          bindings[:view].render partial: 'purchase_payments', locals: {purchase: bindings[:object]}
        end
      end
    end
  end
  config.model 'Sale' do
    show do
      include_all_fields
      field :receipts do
        pretty_value do
          bindings[:view].render partial: 'sale_receipts', locals: {sale: bindings[:object]}
        end
      end
    end
  end
  config.model 'Stock' do
    show do
      # render do
      #   bindings[:view].render :partial => "rails_admin/main/_stock_detail", :locals => {:self => self}
      # end
      include_all_fields
      field :expenses do
        pretty_value do
          bindings[:view].render partial: 'stock_expenses', locals: {stock: bindings[:object]}
        end
      end
      field :stock_histories do
        pretty_value do
          bindings[:view].render partial: 'stock_histories', locals: {stock: bindings[:object]}
        end
      end
    end
  end

  config.model 'SaleItem' do
    edit do
      field :stock do
        inline_edit false
      end
      field :shape do
        partial 'shape'
      end
      field :color do
        partial 'color'
      end
      field :clarity do
        partial 'clarity'
      end
      field :carat do
        partial 'carat'
      end
      field :rap do
        partial 'rap'
      end
      include_all_fields
      field :amount do
        partial 'amount'
      end
    end
  end

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      username == 'aggrawalDiamond' &&
      password == 'aggrawalDiamond123'
    end
  end
end
