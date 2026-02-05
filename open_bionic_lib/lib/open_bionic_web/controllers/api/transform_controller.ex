defmodule OpenBionicWeb.Api.TransformController do
  use OpenBionicWeb, :controller

  alias OpenBionic.Core.{Transformer, Validator}

  @doc """
  GET /api/v1/transform/:text
  Quick transformation via URL path parameter. 
  """
  def show(conn, %{"text" => text}) do
    case Validator.validate_text(text) do
      {:ok, valid_text} ->
        bionic_html = Transformer.boldify(valid_text)
        json(conn, %{success: true, data: %{html: bionic_html}})

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          success: false,
          error: %{
            code: error_code(reason),
            message: Validator.error_message(reason)
          }
        })
    end
  end

  @doc """
  POST /api/v1/transform
  Transform text with optional parameters.
  """
  def create(conn, %{"text" => text} = params) do
    case Validator.validate_text(text) do
      {:ok, valid_text} ->
        bionic_html = Transformer.boldify(valid_text)
        stats = Transformer.stats(valid_text)

        response = %{
          success: true,
          data: %{
            html: bionic_html,
            raw: valid_text,
            stats: stats
          }
        }

        json(conn, response)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          success: false,
          error: %{
            code: error_code(reason),
            message: Validator.error_message(reason)
          }
        })
    end
  end

  # Fallback for missing text parameter
  def create(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{
      success: false,
      error: %{
        code: "MISSING_PARAMETER",
        message: "Missing required parameter: text"
      }
    })
  end

  defp error_code(:empty_text), do: "INVALID_INPUT"
  defp error_code(:text_too_long), do: "TEXT_TOO_LONG"
  defp error_code(:invalid_type), do: "INVALID_INPUT"
  defp error_code(_), do: "INVALID_INPUT"
end
