class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: '会員情報が更新されました'
    else
      @customer = Customer.find(current_customer.id)
      flash.now[:alert] = '会員情報の更新に失敗しました'
      render :edit
    end
  end

  def unsubscribe_confirmation
    @customer = Customer.find(params[:id])
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to root_path, notice: '退会処理が完了致しました'
    else
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
    if @customer.update(is_deleted: true)
      sign_out current_customer
    end
    redirect_to root_path, notice: '退会処理が完了致しました'
  end

  private
  def customer_params
    params.require(:customer).permit(:email, :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end

end
