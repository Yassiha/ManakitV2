class MissionsController < ApplicationController
  before_action :is_member?, only: [:show, :new, :create]
  before_action :is_manager?, only: [:edit, :update, :destroy]

  def show
    @mission = Mission.find(params[:id])
    @tasks = @mission.tasks

    @usernames = []
    @mission.users.each do |user|
      if user.name != nil && user.name != ""
        @usernames << user.name
      else
        @usernames << user.email
      end
    end
    @status = "#{@mission.status.to_s}%"
  end

  def new
    @mission = Mission.new
    @project = Project.find(params[:project_id])
  end

  def create
    mission = Mission.new(mission_params)
    mission.project = Project.find(params[:project_id])
    mission.status = 0
    mission.save
    MissionMember.create(mission: mission, user: current_user)
    mission.project.users.each do |user|
      if mission.users.include?(user)
      else
        MissionMember.create(mission: mission, user: user)
      end
    end

    redirect_to project_path(mission.project)
  end

  def edit
    @mission = Mission.find(params[:id])
  end

  def update
    mission = Mission.find(params[:id])
    mission.update(mission_params)
    mission.save
    redirect_to project_mission_path(mission)
  end

  def destroy
    mission = Mission.find(params[:id])
    project = mission.project
    mission.destroy

    redirect_to project_path(project)
  end

  private

  def mission_params
    params.require(:mission).permit(:title, :description, :start_date, :due_date, :priority, :project_id)
  end

  def is_member?
    if Project.find_by(id: params[:project_id]) != nil && Project.find_by(id: params[:project_id]).users.include?(current_user)
    else
      redirect_to root_path
    end
  end

  def is_manager?
    if Mission.find_by(id: params[:id]) != nil && Mission.find_by(id: params[:id]).project.manager == current_user
    else
      redirect_to root_path
    end
  end
end
