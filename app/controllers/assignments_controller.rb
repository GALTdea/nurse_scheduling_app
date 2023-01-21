class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ show edit update destroy ]

  # GET /assignments or /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1 or /assignments/1.json
  def show
    # @nurses = @shift.unassigned_nurses
  end

  def new
    @shift = Shift.find(params[:shift_id])
    @nurse = Nurse.find(params[:nurse_id])
    @assign = Assign.new(shift_id: @shift.id, nurse_id: @nurse.id)
  end

  # GET /assignments/1/edit
  def edit
  end

  def create
    @shift = Shift.find(params[:assignment][:shift_id])
    @nurse = Nurse.find(params[:assignment][:nurse_id])
  
    @assignments = Assignment.new(shift_id: @shift.id, nurse_id: @nurse.id)
    
    if @assignments.save
      flash[:success] = "Nurse successfully added to shift"
      redirect_to @shift
    else
      flash.now[:danger] = "Failed to add nurse to shift"
      render 'new'
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to assignment_url(@assignment), notice: "Assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url, notice: "Assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.require(:assignment).permit(:details, :nurse_id, :shift_id)
    end
end
