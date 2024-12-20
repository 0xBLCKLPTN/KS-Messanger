defmodule KsMessangerWeb.UserController do
  use KsMessangerWeb, :controller

  alias KsMessanger.Accounts
  alias KsMessanger.Accounts.User

  action_fallback KsMessangerWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
  
  def get_user_by_username_and_password(username, password) do
      user = Repo.get_by(User, username: username)
      
      case user do
        nil -> {:error, :unauthorized}
        _ ->
          if Bcrypt.checkpw(password, user.password_hash) do
            {:ok, user}
          else
            {:error, :unauthorized}
          end
      end
    end
end
