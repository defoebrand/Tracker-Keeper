class TracktionsController < ApplicationController
  before_action :check_user_log_in
  # before_action :set_tracktion, only: %i[show edit update destroy]
  before_action :set_user, except: %i[update destroy]
  # before_action :share_groups, except: %i[index destroy new_type show_type create_type]
  # before_action :share_types, only: %i[new edit create]
  # GET /tracktions
  # GET /tracktions.json
  def index
    @tracktions = Tracktion.includes(:author).includes(:type).eager_load(:groups).all
  end

  # GET /tracktions/1
  # GET /tracktions/1.json
  def show
    @tracktion = Tracktion.includes(:type).eager_load(:groups).find(params[:id])
  end

  # GET /tracktions/new
  def new
    @tracktion = Tracktion.new
    # @tracktion = Tracktion.includes(:type).eager_load(:groups).new
    @types = Type.all
    @groups = Group.all
    # @tracks = Tracktion.all.includes(:type).eager_load(:groups)
  end

  # GET /tracktions/1/edit
  def edit
    @tracktion = Tracktion.find(params[:id])
    @types = Type.all
    @groups = Group.all
    # @fields = Tracktion.eager_load(:type).eager_load(:groups)
    # @fields = Group.all.includes(tracktions: [:type])
    # Type.all.includes(:tracktions => [:groups])
  end

  # POST /tracktions
  # POST /tracktions.json
  def create
    @tracktion = Tracktion.new(tracktion_params.except(:groups))
    # @types = Type.all
    @groups = Group.all

    respond_to do |format|
      tracktion_params.slice(:groups).values.each do |x|
        x.each do |y|
          if y.empty?
          else
            group = @groups.find(y.to_i)
            @tracktion.groups << group
          end
        end
      end
      if @tracktion.save
        format.html { redirect_to @tracktion, notice: 'Tracktion was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tracktions/1
  # PATCH/PUT /tracktions/1.json
  def update
    @tracktion = Tracktion.find(params[:id])
    @tracktion.groups.clear
    @groups = Group.all
    respond_to do |format|
      tracktion_params.slice(:groups).values.each do |x|
        x.each do |y|
          if y.empty?
          else
            group = @groups.find(y.to_i)
            @tracktion.groups << group
          end
        end
      end
      if @tracktion.update(tracktion_params.except(:groups))
        format.html { redirect_to @tracktion, notice: 'Tracktion was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tracktions/1
  # DELETE /tracktions/1.json
  def destroy
    @tracktion.groups.clear
    @tracktion.destroy
    respond_to do |format|
      format.html { redirect_to tracktions_url, notice: 'Tracktion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assigned
    @tracktions = Tracktion.includes(:type).includes(:author).eager_load(:groups).all

    # @transactions = []
    # Tracktion.all.each { |x| @transactions << x if x.author_id == @user.id }
    # # Tracktion.all.each { |x| @transactions << x if (x.author_id == @user.id) && !x.group_id.nil? }
  end

  def unassigned
    @tracktions = Tracktion.includes(:type).includes(:author).eager_load(:groups).all
    # @transactions = []
    # Tracktion.all.each { |x| @transactions << x if (x.author_id == @user.id) && x.group_id.nil? }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tracktion
    @tracktion = Tracktion.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tracktion_params
    params.require(:tracktion).permit(:author_id, :type_id, :name, :amount, groups: [])
  end

  # def share_types
  #   @types = Type.all
  # end
  #
  # # Only allow a list of trusted parameters through.
  # def transaction_params
  #   params.require(:transaction).permit(:authorid, :name, :amount, :amount_type, :group_id, groups: [])
  # end
  #
  # def type_params
  #   params.require(:type).permit(:amount_type)
  # end
end
