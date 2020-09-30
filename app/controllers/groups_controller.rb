class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  # GET /groups
  # GET /groups.json
  def index
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])
      @total = []
      @group.transactions.each { |x| @total << x.amount }
    else
      redirect_to root_path
    end
  end

  # GET /groups/new
  def new
    if session[:user_id]
      @group = Group.new
      @groups = Group.all
      @user = User.find(session[:user_id])
      @group_icons = []
      @groups.each { |x| @group_icons << x.icon unless @group_icons.include?(x.icon) }
    else
      redirect_to root_path
    end
  end

  # GET /groups/1/edit
  def edit
    if session[:user_id]
      @groups = Group.all
      @user = User.find(session[:user_id])
      @group_icons = []
      @groups.each { |x| @group_icons << x.icon unless @group_icons.include?(x.icon) }
    else
      redirect_to root_path
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @groups = Group.all
    @user = User.find(session[:user_id])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
