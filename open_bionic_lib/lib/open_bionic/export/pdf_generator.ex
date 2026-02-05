defmodule OpenBionic.Export.PdfGenerator do
  @moduledoc """
  Generates PDF documents from bionic text using pdf_generator.
  
  Requires wkhtmltopdf to be installed on the system.
  """

  alias OpenBionic.Export.HtmlGenerator

  @doc """
  Generates a PDF from bionic text.
  
  ## Parameters
  
    * `bionic_html` - Transformed text with `<b>` tags
    * `opts` - Optional PDF generation options
    
  ## Returns
  
    * `{:ok, pdf_binary}` on success
    * `{:error, reason}` on failure
  """
  @spec generate(String.t(), Keyword.t()) :: {:ok, binary()} | {:error, any()}
  def generate(bionic_html, opts \\\\ []) do
    # Generate full HTML document
    html_doc = HtmlGenerator.generate(bionic_html, opts)

    # PDF generation options
    pdf_opts = [
      page_size: "A4",
      margin_top: "20mm",
      margin_bottom: "20mm",
      margin_left: "20mm",
      margin_right: "20mm",
      encoding: "UTF-8"
    ]

    try do
      case PdfGenerator.generate_binary(html_doc, pdf_opts) do
        {:ok, pdf_binary} -> {:ok, pdf_binary}
        {:error, reason} -> {:error, reason}
      end
    rescue
      e -> {:error, Exception.message(e)}
    end
  end
end
