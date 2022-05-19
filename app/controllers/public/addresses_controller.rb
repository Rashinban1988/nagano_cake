class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def show
    @address = Address.find(params[:id])
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path, success: "登録完了！"
    else
      @addresses = current_customer.addresses.all
      @address = Address.new(address_params)
      render index, alert: "登録失敗"
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.customer = current_customer
    if @address.update(address_params)
      flash[:notice] = "配送先を更新しました。"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :postal_code, :address, :name)
  end

end
