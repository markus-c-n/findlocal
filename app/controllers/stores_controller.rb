# app/controllers/stores_controller.rb
class StoresController < ApplicationController
  before_action :find_store, only: [:show, :destroy]

  def show
    @items = @store.items
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to items_path, status: :see_other
  end

  private

  def find_store
    @store = Store.find(params[:id])
  end
end
