class GroupsController < ApplicationController
  before_action :check_user_log_in

  def index
    @groups = Group.eager_load(:tracktions).all
  end

  def show
    @group = Group.eager_load(tracktions: [:author]).find(params[:id])
  end

  def new
    @group = Group.new
    @groups = Group.all
  end

  def edit; end

  def create
    @group = Group.new(group_params)
    @groups = Group.all

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
    @group.transactions.clear
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
