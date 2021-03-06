class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      return redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
    return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description]
    )
      redirect_to tasks_path
      return
    else
      render :edit
    return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task
      @task.destroy
      redirect_to tasks_path
    else
      redirect_to tasks_path
    end
  end

  # def toggle_complete
  #   task_id = params[:id]
  #   @task = Task.find_by(id: task_id)
  #
  #   if @task.completed_at.nil?
  #     @task.update(
  #         completed_at: Time.now
  #     )
  #     redirect_to tasks_path
  #   else @task.update(
  #       completed_at: nil
  #   )
  #     redirect_to tasks_path
  #     return
  #   end
  # end
end
