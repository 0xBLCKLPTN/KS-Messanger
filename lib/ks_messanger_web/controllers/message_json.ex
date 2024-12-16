defmodule KsMessangerWeb.MessageJSON do
  alias KsMessanger.Messaging.Message

  @doc """
  Renders a list of messages.
  """
  def index(%{messages: messages}) do
    %{data: for(message <- messages, do: data(message))}
  end

  @doc """
  Renders a single message.
  """
  def show(%{message: message}) do
    %{data: data(message)}
  end

  defp data(%Message{} = message) do
    %{
      id: message.id,
      content_type: message.content_type,
      message_data: message.message_data
    }
  end
end
