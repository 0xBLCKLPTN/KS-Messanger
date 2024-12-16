# lib/ks_messanger_web/controllers/auth_controller.ex
defmodule KsMessangerWeb.AuthController do
  use KsMessangerWeb, :controller
  alias KsMessanger.Guardian
  alias KsMessanger.Accounts
  alias KsMessanger.Accounts.User

  def get_token(conn, %{"username" => username, "password" => password}) do
    case Accounts.get_user_by_username_and_password(username, password) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)
        conn
        |> put_status(:ok)
        |> json(%{token: jwt})

      {:error, :not_found} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "User not found"})

      {:error, :invalid_password} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid Username or password"})

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid Username or password"})
    end
  end

end
