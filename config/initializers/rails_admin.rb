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
    member :download_sale_invoice_btn do
      only ['Sale']
      i18n_key :Invoice
      link_icon 'icon-download'
      action_name 'download_sale_invoice_btn'
    end
    member :download_purchase_invoice_btn do
      only ['Purchase']
      i18n_key :Invoice
      link_icon 'icon-download'
      action_name 'download_purchase_invoice_btn'
    end

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
  config.model 'SalesTax' do
    visible false
  end
  config.model 'PurchasesTax' do
    visible false
  end
  config.model 'SaleItem' do
    visible false
  end
  config.model 'SaleItem' do
    visible false
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
    list do
      scopes [nil, :in_stock_all, :in_stock_loose_diamond, :in_stock_cut_polish_diamond, :in_stock_jewellary]
    end
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
    edit do
      include_fields :stock_sub_type, :title, :stock_pc_range, :rate_per_caret, :loose_total_caret, :loose_selection_carat, :loose_rejection_carat, :discount_percentage, :additional_disc_1, :additional_disc_2, :additional_disc_3, :carat, :amount, :weight, :rap, :state, :shape, :color, :clarity, :certificate_number, :color_shades, :fancy_color, :color_intensity, :color_overtone, :flouresence, :lab, :cut, :polish, :symmetry, :black_table_inclusion, :black_crown_inclusion, :white_table_inclusion, :white_crown_inclusion, :milky_inclusion, :open_table_inclusion, :open_crown_inclusion, :open_pavilion_inclusion, :eye_clean_inclusion, :rough_origin, :heart_and_arrow, :max, :min, :hgt_height, :tbl_table, :td_percentage, :hAndA, :BIC, :BIS, :WIC, :col_tinge, :rapnet_id, :rapnet_dollar, :rapnet_discount_percentage, :rapnet_price_after_disc, :rapnet_amount_dollar_after_disc, :notes, :image_url
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
      # field :rap do
      #   partial 'rap'
      # end
      include_all_fields
      field :amount do
        partial 'amount'
        required true
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
