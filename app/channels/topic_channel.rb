class TopicChannel < ApplicationCable::Channel
  def subscribed
    topic = Topic.find(params[:id])
    stream_for topic
  end
end
