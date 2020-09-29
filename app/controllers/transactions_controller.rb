class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    if session[:user_id]
      if session[:user_id] == 1
        @transactions = Transaction.all
        @user = User.find(session[:user_id])
      else
        redirect_to user_path(session[:user_id])
      end
    else
      redirect_to root_path
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  # GET /transactions/new
  def new
    if session[:user_id]
      @transaction = Transaction.new
      @groups = Group.all
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  # GET /transactions/1/edit
  def edit
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @groups = Group.all
    @user = User.find(session[:user_id])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to user_path(session[:user_id]), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:user_id, :name, :amount, :amount_type, :group_id)
  end
end
