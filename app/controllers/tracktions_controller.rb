class TracktionsController < ApplicationController
  before_action :set_tracktion, only: [:show, :edit, :update, :destroy]

  # GET /tracktions
  # GET /tracktions.json
  def index
    @tracktions = Tracktion.all
  end

  # GET /tracktions/1
  # GET /tracktions/1.json
  def show
  end

  # GET /tracktions/new
  def new
    @tracktion = Tracktion.new
  end

  # GET /tracktions/1/edit
  def edit
  end

  # POST /tracktions
  # POST /tracktions.json
  def create
    @tracktion = Tracktion.new(tracktion_params)

    respond_to do |format|
      if @tracktion.save
        format.html { redirect_to @tracktion, notice: 'Tracktion was successfully created.' }
        format.json { render :show, status: :created, location: @tracktion }
      else
        format.html { render :new }
        format.json { render json: @tracktion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracktions/1
  # PATCH/PUT /tracktions/1.json
  def update
    respond_to do |format|
      if @tracktion.update(tracktion_params)
        format.html { redirect_to @tracktion, notice: 'Tracktion was successfully updated.' }
        format.json { render :show, status: :ok, location: @tracktion }
      else
        format.html { render :edit }
        format.json { render json: @tracktion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracktions/1
  # DELETE /tracktions/1.json
  def destroy
    @tracktion.destroy
    respond_to do |format|
      format.html { redirect_to tracktions_url, notice: 'Tracktion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracktion
      @tracktion = Tracktion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tracktion_params
      params.require(:tracktion).permit(:author_id, :type_id, :name, :amount)
    end
end
