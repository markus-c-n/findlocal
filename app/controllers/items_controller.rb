# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.where(visible: true).includes(store: :items).order("RANDOM()").limit(10)
    @categories = Item.distinct.pluck(:categories).compact.uniq

    if params[:query].present?
      search_query = "%#{params[:query]}%"
      @items = @items.joins(:store).where("items.name ILIKE :query OR :query = ANY(items.categories) OR items.description ILIKE :query", query: search_query)
    end

    if params[:category].present?
      @items = @items.where(":category = ANY(items.categories)", category: params[:category])
    end

    info_window_partial = if params[:query].present?
      "info_window"
    else
      "info_window_store"
    end

    @markers = @items.flat_map do |item|
      marker_html = if params[:query].present?
        render_to_string(partial: "marker", locals: { item: item })
      else
        render_to_string(partial: "marker_store", locals: { item: item })
      end

      {
        lat: item.store.latitude,
        lng: item.store.longitude,
        info_window_html: render_to_string(partial: info_window_partial, locals: { store: item.store, item: item }),
        marker_html: marker_html
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
