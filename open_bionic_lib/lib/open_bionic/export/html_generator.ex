defmodule OpenBionic.Export.HtmlGenerator do
  @moduledoc """
  Generates styled HTML documents from bionic text.
  """

  @default_style """
  <style>
    body {
      font-family: "SF Pro Display", "Segoe UI", -apple-system, BlinkMacSystemFont, sans-serif;
      font-size: 20px;
      line-height: 1.8;
      max-width: 65ch;
      margin: 2rem auto;
      padding: 1rem;
      color: #1A1A1A;
      background: #FAFAFA;
    }
    b {
      font-weight: 700;
    }
    @media (prefers-color-scheme: dark) {
      body {
        color: #FAFAFA;
        background: #0F0F0F;
      }
    }
  </style>
  """

  @doc """
  Generates a complete HTML document from bionic text.
  
  ## Parameters
  
    * `bionic_html` - Transformed text with `<b>` tags
    * `opts` - Optional styling options
    
  ## Returns
  
    * Complete HTML document string
  """
  @spec generate(String.t(), Keyword.t()) :: String.t()
  def generate(bionic_html, opts \\\\ []) do
    title = Keyword.get(opts, :title, "Open.Bionic Reading")
    style = Keyword.get(opts, :style, @default_style)

    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>#{title}</title>
      #{style}
    </head>
    <body>
      #{bionic_html}
    </body>
    </html>
    """
  end
end
