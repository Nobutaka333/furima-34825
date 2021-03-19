class ItemsController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def article_params
    params.require(:item).permit(:name,:text,:category_id,:sale_status_id,:shipping_fee_id,:prefectures_id, :days_to_ship_id,:price,:user )
  end

end
