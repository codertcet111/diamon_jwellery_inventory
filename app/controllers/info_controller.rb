class InfoController < ApplicationController


  def stock_details
    stock = Stock.find_by(id: params[:stock_id])
    render json: {
      carat: stock.carat,
      clarity: Stock.clarities[stock.clarity],
      color: Stock.colors[stock.color],
      shape: Stock.shapes[stock.shape]
    }, status: 200
  end

  def sell_item_amount
    rap_value = params[:rap_value].to_d
    discount_percent = params[:discount_percent].to_d
    disc_1 = params[:disc_1].to_d
    disc_2 = params[:disc_2].to_d
    disc_3 = params[:disc_3].to_d
    dollar_rate = params[:dollar_rate].to_d
    if [dollar_rate, rap_value].include?(0.0)
      render json: { error: 'Dollar Rate or Rap Value is missing. Please check!' }, status: 422
    else
      discount_amount = ((rap_value * (100 - discount_percent)) / 100.0).to_d
      discount_amount = ((discount_amount * (100 - disc_1)) / 100.0).to_d
      discount_amount = ((discount_amount * (100 - disc_2)) / 100.0).to_d
      discount_amount = ((discount_amount * (100 - disc_3)) / 100.0).to_d
      total_amount = (discount_amount * dollar_rate).to_d.round(2)
      render json: { amount: total_amount }, status: 200
    end
  end

end
