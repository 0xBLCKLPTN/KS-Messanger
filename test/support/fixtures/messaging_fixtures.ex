defmodule KsMessanger.MessagingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KsMessanger.Messaging` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content_type: "some content_type",
        message_data: "some message_data"
      })
      |> KsMessanger.Messaging.create_message()

    message
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content_type: "some content_type",
        inserted_at: ~N[2024-12-14 13:49:00],
        message_data: "some message_data"
      })
      |> KsMessanger.Messaging.create_message()

    message
  end
end
