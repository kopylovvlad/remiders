class ItemListsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :check_is_item_list_public, only: [:show]
  before_action :set_item_list, only: [:edit, :update, :destroy]
  before_action :only_owner, only: [:edit, :update, :destroy]

  def index
    @item_lists = current_user.item_lists.limit(6)
  end

  def new
    @item_list = ItemList.new
  end

  def show
    @item = Item.new
  end

  def edit; end

  def create
    @item_list = current_user.item_lists.new item_list_params
    if @item_list.save
      redirect_to item_lists_path, notice: 'Список удачно создан'
    else
      render :new
    end
  end

  def update
    if @item_list.update_attributes item_list_params
      redirect_to item_lists_path, notice: 'Список удачно обновлен'
    else
      render :edit
    end
  end

  def destroy
    @item_list.destroy
    redirect_to item_lists_path, notice: 'Список удачно удален'
  end

  private

  def item_list_params
    params.require(:item_list).permit(
      :title,
      :color,
      :public,
      :description
    )
  end

  def set_item_list
    @item_list = ItemList.find(params[:id])
  end

  def only_owner
    return if current_user == @item_list.user
    redirect_to item_lists_path, alert: 'Манипуляции доступны только над своими элементами' and return
  end

  def check_is_item_list_public
    @item_list = ItemList.preload(:items).find_by(id: params[:id])
    return if @item_list.public?
    authenticate_user!
    only_owner
  end
end
