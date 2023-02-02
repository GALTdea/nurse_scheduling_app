class WeeksController < ApplicationController
  before_action :set_week, only: %i[ show edit update destroy balance_schedule create_shifts ]

  # GET /weeks or /weeks.json
  def index
    @weeks = Week.all
  end

  # GET /weeks/1 or /weeks/1.json
  def show
  end

  # GET /weeks/new
  def new
    @week = Week.new
  end

  # GET /weeks/1/edit
  def edit
  end

  # POST /weeks or /weeks.json
  def create
    @week = Week.new(week_params)

    respond_to do |format|
      if @week.save
        format.html { redirect_to week_url(@week), notice: "Week was successfully created." }
        format.json { render :show, status: :created, location: @week }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @week.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weeks/1 or /weeks/1.json
  def update
    respond_to do |format|
      if @week.update(week_params)
        format.html { redirect_to week_url(@week), notice: "Week was successfully updated." }
        format.json { render :show, status: :ok, location: @week }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @week.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weeks/1 or /weeks/1.json
  def destroy
    @week.destroy

    respond_to do |format|
      format.html { redirect_to weeks_url, notice: "Week was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def create_shifts
    @schedule = Week.create_shifts(@week)
  end

  def balance_schedule
    @schedule = Week.balance_schedule(@week)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week
      @week = Week.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def week_params
      params.require(:week).permit(:week_number, :start_date, :end_date, :year_id)
    end
end
