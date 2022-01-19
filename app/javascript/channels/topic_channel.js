import consumer from "./consumer";

const initTopicCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.topicId;

    consumer.subscriptions.create({ channel: "TopicChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML("afterbegin", data)
      },
    });
  }
}

export { initTopicCable };
