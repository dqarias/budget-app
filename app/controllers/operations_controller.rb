class OperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :acq_category
  before_action :acq_categories
  before_action :set_operation, only: %i[show edit update destroy]

  # GET /operations or /operations.json
  def index
    @operations = @category.operations
  end

  # GET /operations/1 or /operations/1.json
  def show; end

  # GET /operations/new
  def new
    @operation = current_user.operations.build
  end

  # GET /operations/1/edit
  def edit; end

  # POST /operations or /operations.json
  def create
    @operation = current_user.operations.build(operation_params)
    respond_to do |format|
      if @operation.save
        @operation.categories << acq_categories
        format.html { redirect_to category_operations_path(@category), notice: 'Operation was successfully created.' }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to operation_url(@operation), notice: 'Operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Operation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  def acq_category
    @category = Category.find(params[:category_id])
  end

  def acq_categories
    categories = []
    selected_category = Category.find(params[:category_id])
    extra_categories = params[:categories] ? Category.where(id: params[:categories][:category_ids]).to_a : []
    categories << selected_category << extra_categories
    categories.flatten
  end

  # Only allow a list of trusted parameters through.
  def operation_params
    params.require(:operation).permit(:name, :amount, :user_id)
  end
end
