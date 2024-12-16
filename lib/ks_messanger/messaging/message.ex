defmodule KsMessanger.Messaging.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "messages" do
    field :content_type, :string
    field :message_data, :string
    field :chat_id, :binary_id
    field :from_user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content_type, :message_data])
    |> validate_required([:content_type, :message_data])
  end
end
