# app/controllers/stores_controller.rb
class StoresController < ApplicationController
  before_action :find_store, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

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
    @store = Store.find(params[:id])
    authorize @store
    @store.destroy
    redirect_to items_path, status: :see_other
  end

  def new
    @store = current_user.stores.build
  end

  def edit
    @store = Store.find(params[:id])
    authorize @store
  end

  def index
    @stores = current_user.stores
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
  end

  def update
    @store = Store.find(params[:id])
    authorize @store
    if @store.update(store_params)
      redirect_to store_path(@store), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @store = current_user.stores.build(store_params)
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
    params.require(:store).permit(:name, :address, :opening_times, :description, :photo)
  end
end
