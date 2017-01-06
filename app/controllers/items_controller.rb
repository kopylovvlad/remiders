class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_list
  before_action :set_item, only: [:show, :update, :destroy]

  def create
    @item = @item_list.items.create!(item_params)

    respond_to do |format|
      format.html { redirect_to @item_list and return }
      format.js
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def update
    is_done_before = @item.is_done
    @item.update_attributes!(item_params)
    @is_done_changed = is_done_before != @item.is_done

    respond_to do |format|
      format.html { redirect_to @item_list and return }
      format.js
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to @item_list and return }
      format.js
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :title,
      :description,
      :deadline,
      :priority,
      :is_done
    )
  end

  def set_item_list
    @item_list = ItemList.find(params[:item_list_id])
  end

  def set_item
    @item = @item_list.items.find(params[:id])
  end
end
