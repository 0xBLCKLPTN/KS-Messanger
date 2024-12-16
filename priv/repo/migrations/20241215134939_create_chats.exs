defmodule KsMessanger.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :chat_name, :string
      add :members, {:array, :string}

      timestamps(type: :utc_datetime)
    end
  end
end
