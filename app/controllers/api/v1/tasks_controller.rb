class Api::V1::TasksController < ApplicationController
  def index
    task = Task.all.order(created_at: :desc)
    render json: task
  end

  def create
    task = Task.create!(task_params)
    if task
      render json: task
    else
      render json: task.error
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      render json: task
    else
      render json: task.error
    end
  end

  def show
    if task
      render json: task
    else
      render json: task.error
    end
  end

  def destroy
    task&.destroy
    render json: { message: 'Task Decimated!' }
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :deadline, :status, :tags)
  end

  def task
    @task ||= Task.find(params[:id])
  end
end
