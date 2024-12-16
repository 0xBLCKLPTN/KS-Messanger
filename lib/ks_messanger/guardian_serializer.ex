# lib/ks_messanger/guardian_serializer.ex
defmodule KsMessanger.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Guardian.Serializer

  @impl true
  def for_token(user = %KsMessanger.Accounts.User{}, _claims, _opts) do
    Serializer.for_token(%{id: user.id, username: user.username})
  end

  @impl true
  def for_token_key(_key), _claims, _opts do
    nil
  end

  @impl true
  def from_token(map), _opts do
    Serializer.from_token(map)
  end

  @impl true
  def from_token_key(_key), _opts do
    nil
  end
end
