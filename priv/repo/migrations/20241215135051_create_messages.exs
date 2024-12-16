defmodule KsMessanger.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content_type, :string
      add :message_data, :text
      add :chat_id, references(:chats, on_delete: :nothing, type: :binary_id)
      add :from_user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:messages, [:chat_id])
    create index(:messages, [:from_user_id])
  end
end
