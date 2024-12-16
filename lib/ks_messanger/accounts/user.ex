defmodule KsMessanger.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :is_online, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username, :password_hash, :is_online])
    |> validate_required([:first_name, :last_name, :username, :password_hash, :is_online])
    |> unique_constraint(:username)
    |> put_password_hash()
  end
  
  defp put_password_hash(changeset) do
      case get_change(changeset, :password_hash) do
        nil -> changeset
        pass -> put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
      end
    end
end
