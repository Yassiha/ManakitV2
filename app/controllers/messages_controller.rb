class MessagesController < ApplicationController
    before_action :is_member?

    def create
      content = params_messages[:content].html_safe
      message = Message.new(content: content)
      message.user = current_user
      message.topic = Topic.find(params[:topic_id])
      message.save
      TopicChannel.broadcast_to(
        message.topic,
        render_to_string(partial: "message", locals: { message: message })
      )
      redirect_to project_mission_topic_path(message.topic.mission.project, message.topic.mission, message.topic)
    end

    def edit
      @message = Message.find(params[:id])
    end

    def update
      message = Message.find(params[:id])
      message.update(params_messages)
      message.save

      redirect_to project_mission_topic_path(message.topic.mission.project, message.topic.mission, message.topic)
    end

    def destroy
    end

    private

    def params_messages
      params.require(:message).permit(:content)
    end

    def is_member?
      if Project.find_by(id: params[:project_id]) != nil && Project.find_by(id: params[:project_id]).users.include?(current_user)
      else
        redirect_to root_path
      end
    end

end
