class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    if session[:user_id]
      @transactions_test = Transaction.first

      @user = User.find(session[:user_id])
      @transactions = Transaction.all.where(authorid: @user.id)
      @assigned_type_sums = {}
      @unassigned_type_sums = {}
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
      # @types = Type.all
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
      @types = Type.all
      # @types = []
      # Transaction.all.each { |x| @types << x.amount_type unless @types.include?(x.amount_type) }
    else
      redirect_to root_path
    end
  end

  # GET /transactions/1/edit
  def edit
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])
      @types = Type.all
    else
      redirect_to root_path
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params.except(:groups))
    @groups = Group.all
    @user = User.find(session[:user_id])
    @types = Type.all

    respond_to do |format|
      transaction_params.slice(:groups).values.each do |x|
        x.each do |y|
          if y.empty?
          else
            group = @groups.find(y.to_i)
            @transaction.groups << group
          end
        end
      end
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
    @groups = Group.all
    respond_to do |format|
      transaction_params.slice(:groups).values.each do |x|
        x.each do |y|
          if y.empty?
          else
            group = @groups.find(y.to_i)
            @transaction.groups << group
          end
        end
      end
      if @transaction.update(transaction_params.except(:groups))
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

  def assigned_transactions
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])

      @transactions = Transaction.all.where(authorid: @user.id)
      @assigned_type_sums = {}
      # @types = Type.all
    else
      redirect_to root_path
    end
  end

  def unassigned_transactions
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])
      @transactions = Transaction.all.where(authorid: @user.id)
      @unassigned_type_sums = {}
      # @types = Type.all
    else
      redirect_to root_path
    end
  end

  def new_type
    if session[:user_id]
      @type = Type.new
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def show_type
    if session[:user_id]
      @type = Type.new
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def create_type
    # @transaction = Transaction.new(transaction_params)
    @type = Type.new(type_params)
    @user = User.find(session[:user_id])

    respond_to do |format|
      if @type.save
        format.html { redirect_to new_transaction_path, notice: 'Type was successfully created.' }
        format.json { render :show_type, status: :created, location: @type }
      else
        format.html { render :new_type }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:authorid, :name, :amount, :amount_type, :group_id, groups: [])
  end

  def type_params
    params.require(:type).permit(:amount_type)
  end
end
