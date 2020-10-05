class TypesController < ApplicationController
  def new
    set_user
    @type = Type.new
  end

  def show
    set_user
    @transactions = Tracktion.all
    @type = Type.find_by(params[:amount_type])
  end

  def create
    set_user
    @type = Type.new(type_params)

    respond_to do |format|
      if @type.save
        format.html { redirect_to new_tracktion_path, notice: 'Type was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tracktions/1
  # PATCH/PUT /tracktions/1.json
  def update
    # @tracktion.groups.clear
    respond_to do |format|
      if @type.update(tracktion_params)
        format.html { redirect_to @type, notice: 'Type was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tracktions/1
  # DELETE /tracktions/1.json
  def destroy
    # @tracktion.groups.clear
    @type.destroy
    respond_to do |format|
      format.html { redirect_to types_url, notice: 'Type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def type_params
    params.require(:type).permit(:amount_type)
  end
end
