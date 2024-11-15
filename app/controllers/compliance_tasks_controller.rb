class ComplianceTasksController < ApplicationController

  def index
    tasks = ComplianceTask.all
    tasks = tasks.where(status: params[:status]) if params[:status].present?
    tasks = tasks.where("due_date < ?", params[:due_date]) if params[:due_date].present?

    render json: { tasks: tasks, message: "Compliance tasks retrieved successfully" }, status: :ok
  end

  def show
    task = ComplianceTask.find_by(id: params[:id])

    if task
      render json: { task: task, message: "Compliance task retrieved successfully" }, status: :ok
    else
      render json: { error: "Compliance task not found" }, status: :not_found
    end
  end

  def create
    task = ComplianceTask.new(compliance_task_params)

    if task.save
      render json: { task: task, message: "Compliance task created successfully" }, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    task = ComplianceTask.find_by(id: params[:id])

    if task
      if task.update(compliance_task_params)
        render json: { task: task, message: "Compliance task updated successfully" }, status: :ok
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Compliance task not found" }, status: :not_found
    end
  end

  def destroy
    task = ComplianceTask.find_by(id: params[:id])

    if task
      task.destroy
      render json: { message: "Compliance task deleted successfully" }, status: :no_content
    else
      render json: { error: "Compliance task not found" }, status: :not_found
    end
  end

  private

  def compliance_task_params
    params.require(:compliance_task).permit(:title, :status, :description, :due_date)
  end
end
