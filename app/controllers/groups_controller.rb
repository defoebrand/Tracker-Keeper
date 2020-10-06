class GroupsController < ApplicationController
  before_action :check_user_log_in

  def index
    @groups = Group.eager_load(:tracktions).all
  end

  def show
    @group = Group.eager_load(tracktions: [:author]).find(params[:id])
  end

  def new
    @groups = Group.all
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
    ## only add distinct icons in group.all? to allow multiple groups to share an icon
    @groups = Group.all
  end

  def create
    @groups = Group.all
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
    @groups = Group.all
    @group = Group.find(params[:id])
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
