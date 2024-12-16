defmodule KsMessanger.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KsMessanger.Chats` context.
  """

  @doc """
  Generate a chat.
  """
  def chat_fixture(attrs \\ %{}) do
    {:ok, chat} =
      attrs
      |> Enum.into(%{
        chat_name: "some chat_name",
        members: ["option1", "option2"]
      })
      |> KsMessanger.Chats.create_chat()

    chat
  end
end
