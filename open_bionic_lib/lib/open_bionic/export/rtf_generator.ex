defmodule OpenBionic.Export.RtfGenerator do
  @moduledoc """
  Generates RTF (Rich Text Format) documents from bionic text.
  
  RTF format allows the document to be opened in Word, WordPad, etc.
  """

  @doc """
  Converts HTML bionic text to RTF format.
  
  ## Parameters
  
    * `bionic_html` - Transformed text with `<b>` tags
    
  ## Returns
  
    * RTF document string
  """
  @spec generate(String.t()) :: String.t()
  def generate(bionic_html) do
    # Convert HTML tags to RTF bold codes
    rtf_text =
      bionic_html
      |> String.replace("<b>", "\\\\b ")
      |> String.replace("</b>", "\\\\b0 ")

    # RTF document structure
    """
    {\\rtf1\\ansi\\deff0
    {\\fonttbl{\\f0\\fswiss SF Pro Display;}}
    {\\colortbl;\\red26\\green26\\blue26;}
    \\f0\\fs40
    #{rtf_text}
    }
    """
  end
end
