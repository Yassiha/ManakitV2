class AddProjectMemberController < ApplicationController
  before_action :is_manager?

  def new
    @user = User.new
  end

  def create
    if User.where(email: user_params[:email])
      user = User.find_by_email(user_params[:email])
      project = Project.find(params[:project_id])
      ProjectMember.create(user: user, project: project)
      project.missions.each do |mission|
        MissionMember.create(user: user, mission: mission)
      end
      redirect_to project_path(project)
    else
      redirect_to new_project_add_project_member_path
    end
  end

  def destroy
    user = User.find(params[:id])
    project = Project.find(params[:project_id])
    ProjectMember.where(user: user, project: project)[0].destroy
    project.missions.each do |mission|
      MissionMember.where(user: user, mission: mission).each do |mission_member|
        mission_member.destroy
      end
    end
    redirect_to project_path(project)
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def is_manager?
    project = Project.find(params[:project_id])
    if project.manager = current_user
    else
      redirect_to root_path
    end
  end

end
