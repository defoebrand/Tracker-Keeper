class TracktionsController < ApplicationController
  before_action :check_user_log_in # , except: %i[update destroy]

  def index
    @tracktions = Tracktion.includes(:author).includes(:type).eager_load(:groups).all
  end

  def show
    @tracktion = Tracktion.includes(:type).eager_load(:groups).find(params[:id])
  end

  def new
    @tracktion = Tracktion.new
  end

  def edit
    @tracktion = Tracktion.eager_load(:groups).find(params[:id])
  end

  def create
    # user .build or .create line here to prefil tables
    @tracktion = Tracktion.includes(:author).includes(:type).eager_load(:groups).new(tracktion_params.except(:groups))

    @array = []
    respond_to do |format|
      tracktion_params.slice(:groups).values.each do |x|
        x.each do |y|
          if y.empty?
          else
            @array << y.to_i
          end
        end
        @groups = Group.preload(:tracktions).find_by(id: @array)
        # @tracktion.groups << Group.find(@array)
        @tracktion.groups << @groups
      end
      if @tracktion.save
        format.html { redirect_to @tracktion, notice: 'Tracktion was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @tracktion = Tracktion.includes(:author).includes(:type).eager_load(:groups).find(params[:id])
    @tracktion.groups.clear
    @array = []
    respond_to do |format|
      tracktion_params.slice(:groups).values.each do |x|
        x.each do |y|
          if y.empty?
          else
            @array << y.to_i
            # group = @groups.find(y.to_i)
            # @tracktion.groups << Group.find(y.to_i)
            # group = @groups.find(y.to_i)
            # @tracktion.groups << group
          end
        end
        # @groups = Group.find(@array)
        @tracktion.groups << Group.find(@array)
        # Group.transaction do
        #   @tracktion.groups << Group.find(@array)
        # end
      end
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
    @tracktions = Tracktion.includes(:type).includes(:author).eager_load(:groups).select do |track|
      track if track.groups.first
    end
  end

  def unassigned
    @tracktions = Tracktion.includes(:type).includes(:author).eager_load(:groups).select do |track|
      track unless track.groups.first
    end
  end

  private

  def tracktion_params
    params.require(:tracktion).permit(:author_id, :type_id, :name, :amount, groups: [])
  end
end
