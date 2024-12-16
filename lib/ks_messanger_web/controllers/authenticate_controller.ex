defmodule KsMessangerWeb.AuthenticateController do
  use KsMessangerWeb, :controller

  alias KsMessanger.Accounts
  alias KsMessanger.Accounts.User

  action_fallback KsMessangerWeb.FallbackController
  
  def signIn(conn, %{"user" => user_params})
end
