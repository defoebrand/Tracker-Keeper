class TransactionsController < ApplicationController
  before_action :check_user_log_in
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :set_user, except: %i[update destroy]
  before_action :share_groups, except: %i[index destroy new_type show_type create_type]
  before_action :share_types, only: %i[new edit create]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all.where(authorid: @user.id)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params.except(:groups))

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
    @transaction.groups.clear
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
    @transaction.groups.clear
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to user_path(session[:user_id]), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assigned_transactions
    @transactions = []
    Transaction.all.each { |x| @transactions << x if (x.authorid == @user.id) && !x.group_id.nil? }
  end

  def unassigned_transactions
    @transactions = []
    Transaction.all.each { |x| @transactions << x if (x.authorid == @user.id) && x.group_id.nil? }
  end

  def new_type
    @type = Type.new
  end

  def show_type
    @transactions = Transaction.all
    @type = Type.find_by(params[:amount_type])
  end

  def create_type
    @type = Type.new(type_params)

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

  def share_types
    @types = Type.all
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:authorid, :name, :amount, :amount_type, :group_id, groups: [])
  end

  def type_params
    params.require(:type).permit(:amount_type)
  end
end
