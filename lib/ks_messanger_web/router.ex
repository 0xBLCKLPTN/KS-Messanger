defmodule KsMessangerWeb.Router do
  use KsMessangerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KsMessangerWeb do
    pipe_through :api
    resources "/users", UserController
    resources "/chats", ChatController
    resources "/message", MessageController
    post("/login", AuthController, :get_token)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ks_messanger, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]
      
      live_dashboard "/dashboard", metrics: KsMessangerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
