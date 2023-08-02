# app/controllers/stores_controller.rb
class StoresController < ApplicationController
  before_action :find_store, only: [:edit, :show, :update, :destroy]

  def show
    @store = Store.find(params[:id])
    @items = @store.items.where(visible: true)
    @all_items = @store.items
    @markers = [{
      lat: @store.latitude,
      lng: @store.longitude,
      marker_html: render_to_string(partial: "marker", locals: { store: @store })
    }]
  end

  def destroy
    @store.destroy
    redirect_to items_path, status: :see_other
  end

  def new
    @store = Store.new
  end

  def edit
  end

  def index
    @stores = Store.all
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
  end

  def update
    if @store.update(store_params)
      redirect_to store_path(@store), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to store_path(@store)
    else
      # display the form for the user again
      render :new, status: :unprocessable_entity
    end
  end

  private
  def find_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :address, :opening_times, :description)
  end
end
