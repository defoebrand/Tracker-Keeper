class GroupsController < ApplicationController
  before_action :check_user_log_in
  # before_action :set_user, :share_groups, except: %i[update destroy]
  before_action :set_user, except: %i[update destroy]
  # before_action :set_group, only: %i[show edit update destroy]
  # before_action :group_icons, only: %i[new edit]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.eager_load(:tracktions).all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    # @group = Group.find(params[:id]).eager_load(:tracktions).all
    # @group = Group.joins(:tracktions, :users).find(params[:id])
    # @group = Group.joins('INNER JOIN user on tracktions.author_id = user.id').select('*').find(params[:id])
    @group = Group.eager_load(tracktions: [:author]).find(params[:id])

    # Subscription.joins("INNER JOIN plans ON plans.id = subscriptions.plan_id
    #                 INNER JOIN roles ON roles.id = plans.role_id").where("roles.name = 'Gold'").first
    # (:plan => [:role])

    # Address.joins('INNER JOIN phones on addresses.person_id = phones.person_id').select("addresses.*, phones.*").limit(1)
    # @groups = Group.eager_load(:tracktions)
    # @groups = Group.eager_load(:tracktions).all
    # @groups_count = Group.eager_load(:tracktions).count
    # @total = []
    # @group.transactions.each { |x| @total << x.amount }
  end

  # GET /groups/new
  def new
    @group = Group.new
    @groups = Group.all
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @groups = Group.all

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
    @group.transactions.clear
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

  def group_icons
    @group_icons = []
    @groups.each { |x| @group_icons << x.icon unless @group_icons.include?(x.icon) }
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
