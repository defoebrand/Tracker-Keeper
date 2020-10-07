class TracktionsController < ApplicationController
  before_action :check_user_log_in

  def index
    @tracktions = Tracktion.includes(:author).includes(:type).includes(:groups).eager_load([:groups_tracktions]).all
  end

  def show
    @tracktion = Tracktion.includes(:author).includes(:type).eager_load(:groups).find(params[:id])
  end

  def new
    @tracktion = Tracktion.new
  end

  def edit
    @tracktion = Tracktion.eager_load(:groups).find(params[:id])
  end

  def create
    @tracktion = Tracktion.includes(:author).includes(:type).eager_load(:groups).new(tracktion_params.except(:groups))

    respond_to do |format|
      add_groups(tracktion_params)
      if @tracktion.save
        format.html { redirect_to @tracktion, notice: 'Tracktion was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @tracktion = Tracktion.includes(:author).includes(:type).eager_load(:groups).find(params[:id])

    respond_to do |format|
      add_groups(tracktion_params)
      if @tracktion.update(tracktion_params.except(:groups))
        format.html { redirect_to @tracktion, notice: 'Tracktion was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tracktion = Tracktion.includes(:groups).find(params[:id])
    @tracktion.groups.clear
    @tracktion.destroy
    respond_to do |format|
      format.html { redirect_to tracktions_url, notice: 'Tracktion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assigned
    @tracktions = Tracktion.includes(:type).includes(:author).includes(:groups)
                           .eager_load([:groups_tracktions]).select do |track|
      track if track.groups.first
    end
  end

  def unassigned
    @tracktions = Tracktion.includes(:type).includes(:author).includes(:groups)
                           .eager_load([:groups_tracktions]).select do |track|
      track unless track.groups.first
    end
  end

  private

  def tracktion_params
    params.require(:tracktion).permit(:author_id, :type_id, :name, :amount, groups: [])
  end

  def add_groups(tracktion_params)
    @tracktion.groups.clear
    @array = []
    tracktion_params.slice(:groups).values.flatten.each do |group_name|
      @array << group_name unless group_name.empty?
    end
    @groups = Group.eager_load(:tracktions)
    @array.size.times do |xyz|
      @tracktion.groups << @groups.find_by(name: @array[xyz])
    end
  end
end
