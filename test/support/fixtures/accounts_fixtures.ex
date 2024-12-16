defmodule KsMessanger.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KsMessanger.Accounts` context.
  """

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        is_online: true,
        last_name: "some last_name",
        password_hash: "some password_hash",
        username: unique_user_username()
      })
      |> KsMessanger.Accounts.create_user()

    user
  end
end
