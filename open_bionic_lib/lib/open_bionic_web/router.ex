defmodule OpenBionicWeb.Router do
  use OpenBionicWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["*"]
  end

  # API Routes
  scope "/api/v1", OpenBionicWeb.Api do
    pipe_through :api

    # Health check
    get "/health", HealthController, :index

    # Text transformation
    get "/transform/:text", TransformController, :show
    post "/transform", TransformController, :create

    # Exports
    post "/export/html", ExportController, :html
    post "/export/rtf", ExportController, :rtf
    post "/export/pdf", ExportController, :pdf
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:open_bionic, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: OpenBionicWeb.Telemetry
    end
  end
end
