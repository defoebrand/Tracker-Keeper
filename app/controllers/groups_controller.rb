class GroupsController < ApplicationController
  before_action :check_user_log_in
  before_action :set_group, only: %i[edit update destroy]
  before_action :share_groups, only: %i[new edit create update]

  def index
    @groups = Group.eager_load(:tracktions).all
  end

  def show
    @group = Group.eager_load(tracktions: %i[author type]).find(params[:id])
    @type_sums = {}
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def share_groups
    @groups = Group.all
  end
end
