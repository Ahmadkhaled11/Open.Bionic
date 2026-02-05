defmodule OpenBionicWeb.Api.HealthController do
  use OpenBionicWeb, :controller

  @doc """
  GET /api/v1/health
  Health check endpoint for monitoring.
  """
  def index(conn, _params) do
    json(conn, %{
      status: "healthy",
      version: "1.0.0",
      service: "Open.Bionic API"
    })
  end
end
