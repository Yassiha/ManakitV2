class TopicsController < ApplicationController
  before_action :is_member?
  before_action :is_manager?, only: [:new, :create, :edit, :update, :destroy]

  def new
    @topic = Topic.new
    @project = Project.find_by(id: params[:project_id])
    @mission = Mission.find_by(id: params[:mission_id])
  end

  def create
    topic = Topic.new(topic_params)
    topic.mission = Mission.find(params[:mission_id])
    topic.save

    redirect_to project_mission_path(topic.mission.project, topic.mission)
  end

  def show
    @topic = Topic.find_by(id: params[:id])
    @message = Message.new
  end

  def edit
    @topic = Topic.find_by(id: params[:id])
  end

  def update
    topic = Topic.find_by(id: params[:id])
    topic.title = topic_params[:title]
    if topic_params[:status] == 'Close'
      topic.status = 1
    elsif topic_params[:status] == 'Open'
      topic.status = 2
    end
    topic.save

    redirect_to project_mission_topic_path(topic.mission.project, topic.mission)

  end

  def destroy
    topic = Topic.find_by(id: params[:id])
    project = topic.mission.project
    mission = topic.mission
    topic.destroy

    redirect_to project_mission_path(project, mission)
  end

    private

  def topic_params
    params.require(:topic).permit(:title, :status)
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
