defmodule KsMessangerWeb.MessageController do
  use KsMessangerWeb, :controller

  alias KsMessanger.Messaging
  alias KsMessanger.Messaging.Message

  action_fallback KsMessangerWeb.FallbackController

  def index(conn, _params) do
    messages = Messaging.list_messages()
    render(conn, :index, messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- Messaging.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/messages/#{message}")
      |> render(:show, message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Messaging.get_message!(id)
    render(conn, :show, message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Messaging.get_message!(id)

    with {:ok, %Message{} = message} <- Messaging.update_message(message, message_params) do
      render(conn, :show, message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Messaging.get_message!(id)

    with {:ok, %Message{}} <- Messaging.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
