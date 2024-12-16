defmodule KsMessanger.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chats" do
    field :chat_name, :string
    field :members, {:array, :string}

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:chat_name, :members])
    |> validate_required([:chat_name, :members])
  end
end
