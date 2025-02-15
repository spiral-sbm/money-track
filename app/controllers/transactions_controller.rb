class TransactionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  
    def index
      @transactions = current_user.transactions
    end
  
    def show
    end
  
    def new
      @transaction = Transaction.new
    end
  
    def create
      @transaction = current_user.transactions.build(transaction_params)
      if @transaction.save
        redirect_to authenticated_root_path, notice: 'Transaction was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @transaction.update(transaction_params)
        redirect_to authenticated_root_path, notice: 'Transaction was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @transaction.destroy
      redirect_to transactions_path, notice: 'Transaction was successfully destroyed.'
    end
  
    private
  
    def set_transaction
      @transaction = current_user.transactions.find(params[:id])
    end
  
    def transaction_params
      params.require(:transaction).permit(:amount, :description, :date, :category_id, :bank_account_id)
    end
end
  