class TasksController < ApplicationController
  before_action :is_member?
  before_action :is_manager?, only: [:new, :create, :edit, :update, :destroy]

  def show
    @task = Task.find_by(id: params[:id])
    @status = "#{@task.status.to_s}%"
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def create
    task = Task.new(task_params)
    task.mission = Mission.find(params[:mission_id])
    task.status = 0
    task.save
    update_status(task.mission)
    redirect_to project_mission_path(params[:project_id], params[:mission_id])
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    task.save
    task.status = task_params[:status].to_i
    if task_params[:finish] == "1"
      task.finish = true
    else
      task.finish = false
    end
    task.finish = true if task.status == 100
    task.status = 100 if task.finish == true
    task.finish = false if task.status < 100
    task.save
    update_status(task.mission)

    redirect_to project_mission_task_path(task.mission.project, task.mission, task)
  end

  def destroy
    task = Task.find(params[:id])
    mission = task.mission
    task.destroy
    redirect_to project_mission_path(mission.project, mission)
  end

  private

  def update_status(mission)
    tasks = mission.tasks
    total = 0
    tasks.each do |task|
      total += task.status.nil? ? 0 : task.status
    end
    mission.status = total / (tasks.count > 0 ? tasks.count : 1)
    mission.save
    project = mission.project
    missions = project.missions
    total = 0
    missions.each do |mission|
      total += mission.status.nil? ? 0 : mission.status
    end
    project.status = total / (missions.count > 0 ? missions.count : 1)
    project.save
  end

  def task_params
    params.require(:task).permit(:start_date, :due_date, :title, :description, :priority, :status, :finish, :mission_id)
  end

  def is_member?
    if Project.find_by(id: params[:project_id]) != nil && Project.find_by(id: params[:project_id]).users.include?(current_user)
    else
      redirect_to root_path
    end
  end

  def is_manager?
    if Project.find_by(id: params[:project_id]) != nil && Project.find_by(id: params[:project_id]).manager == current_user
    else
      redirect_to root_path
    end
  end

end
