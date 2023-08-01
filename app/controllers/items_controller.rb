# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.where(visible: true).includes(store: :items).order("RANDOM()").limit(10)
    if params[:query].present?
      sql_subquery = <<~SQL
        items.name @@ :query
        OR items.categories @@ :query
      SQL
      @items = @items.joins(:store).where(sql_subquery, query: params[:query])
    end
    @markers = @items.flat_map do |item|
      {
        lat: item.store.latitude,
        lng: item.store.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { store: item.store, item: item }),
        marker_html: render_to_string(partial: "marker", locals: { item: item })
      }
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to store_path(@item.store), notice: 'Item was successfully added to the stock.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to store_path(@item.store), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to store_path(@item.store), status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :stock_quantity, :description, :categories, :pictures, :visible, :store_id)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
