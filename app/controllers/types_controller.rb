class TypesController < ApplicationController
  before_action :check_user_log_in
  def new
    @type = Type.new
  end

  def show
    @type = Type.eager_load(tracktions: [:groups]).find(params[:id])
  end

  def create
    @type = Type.new(type_params)
    respond_to do |format|
      if @type.save
        format.html { redirect_to new_tracktion_path, notice: 'Type was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def type_params
    params.require(:type).permit(:amount_type)
  end
end
