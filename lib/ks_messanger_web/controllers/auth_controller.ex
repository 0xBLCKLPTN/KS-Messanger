defmodule KSMessanger.AuthController do
  use KSMessanger, :controller

  alias KSMessanger.Auth

  def login(conn, %{"user" => user_params}) do
    Auth.login(conn, user_params)
  end
end