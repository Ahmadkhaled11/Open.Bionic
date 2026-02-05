defmodule OpenBionicWeb.Api.ExportController do
  use OpenBionicWeb, :controller

  alias OpenBionic.Core.{Transformer, Validator}
  alias OpenBionic.Export.{HtmlGenerator, RtfGenerator, PdfGenerator}

  @doc """
  POST /api/v1/export/html
  Export as styled HTML document.
  """
  def html(conn, %{"text" => text}) do
    case Validator.validate_text(text) do
      {:ok, valid_text} ->
        bionic_html = Transformer.boldify(valid_text)
        html_doc = HtmlGenerator.generate(bionic_html)

        conn
        |> put_resp_content_type("text/html")
        |> send_resp(200, html_doc)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          success: false,
          error: %{code: "INVALID_INPUT", message: Validator.error_message(reason)}
        })
    end
  end

  @doc """
  POST /api/v1/export/rtf
  Export as RTF document.
  """
  def rtf(conn, %{"text" => text}) do
    case Validator.validate_text(text) do
      {:ok, valid_text} ->
        bionic_html = Transformer.boldify(valid_text)
        rtf_doc = RtfGenerator.generate(bionic_html)

        conn
        |> put_resp_content_type("application/rtf")
        |> put_resp_header("content-disposition", "attachment; filename=\\"openbionic.rtf\\"")
        |> send_resp(200, rtf_doc)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          success: false,
          error: %{code: "INVALID_INPUT", message: Validator.error_message(reason)}
        })
    end
  end

  @doc """
  POST /api/v1/export/pdf
  Export as PDF document.
  """
  def pdf(conn, %{"text" => text}) do
    case Validator.validate_text(text) do
      {:ok, valid_text} ->
        bionic_html = Transformer.boldify(valid_text)

        case PdfGenerator.generate(bionic_html) do
          {:ok, pdf_binary} ->
            conn
            |> put_resp_content_type("application/pdf")
            |> put_resp_header("content-disposition", "attachment; filename=\\"openbionic.pdf\\"")
            |> send_resp(200, pdf_binary)

          {:error, reason} ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{
              success: false,
              error: %{code: "EXPORT_FAILED", message: "PDF generation failed: #{inspect(reason)}"}
            })
        end

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          success: false,
          error: %{code: "INVALID_INPUT", message: Validator.error_message(reason)}
        })
    end
  end
end
