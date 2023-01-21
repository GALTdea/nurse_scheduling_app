class Shift::AssignmentsController < ApplicationController
# class Dashboard::ProfileController < ApplicationController

  def create
    @shift = Shift.find(params[:shift_id])
    @nurse = Nurse.find(params[:nurse_id])
    @assign = Assign.new(shift_id: @shift.id, nurse_id: @nurse.id)
    if @assignment.save
      flash[:success] = "Nurse successfully added to shift"
      redirect_to @assignment.shift
    else
      flash.now[:danger] = "Failed to add nurse to shift"
      render 'new'
    end
  end



  def assignment_params
    params.require(:assignment).permit(:details, :nurse_id, :shift_id, nurse_ids: [])
  end
end