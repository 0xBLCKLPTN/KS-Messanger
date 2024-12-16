# lib/ks_messanger/auth/auth.ex
defmodule KsMessanger.Auth do
  use Guardian.Plug, otp_app: :ks_messanger
  import Plug.Conn

  def login(conn, %{"username" => username, "password" => password}) do
    case KsMessanger.Accounts.get_user_by_username_and_password(username, password) do
      {:ok, user} ->
        {:ok, jwt, _claims} = Guardian.encode_and_sign(user)
        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> send_resp(:ok, %{token: jwt})

      {:error, :unauthorized} ->
        conn
        |> send_resp(:unauthorized, %{error: "Invalid email or password"})
    end
  end
end
