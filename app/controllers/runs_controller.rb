# frozen_string_literal: true

class RunsController < ProtectedController
  before_action :set_run, only: %i[show update destroy]

  # GET /runs
  # GET /runs?individual=true
  def index
    # request.query_parameters
    # params[:individual]
    puts params[:individual]
    if params[:individual] == 'true'
      @runs = current_user.runs.all.order(:date)
    else
      @runs = Run.all.order(:date)
    end

    render json: @runs
  end

  # GET /runs/1
  def show
    render json: @run
  end

  # POST /runs
  def create
    @run = current_user.runs.build(run_params)

    if @run.save
      render json: @run, status: :created, location: @run
    else
      render json: @run.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /runs/1
  def update
    if @run.update(run_params)
      render json: @run
    else
      render json: @run.errors, status: :unprocessable_entity
    end
  end

  # DELETE /runs/1
  def destroy
    @run.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_run
    @run = current_user.runs.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def run_params
    params.require(:run).permit(:date, :distance, :run_time, :place, :user_id)
  end
end
