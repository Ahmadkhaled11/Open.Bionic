defmodule OpenBionic.Core.Transformer do
  @moduledoc """
  Core bionic text transformation algorithm.
  
  Converts regular text to bionic reading format by bolding the first half
  of each word to aid focus and comprehension for ADHD readers.
  
  ## Algorithm
  
  For each word:
  - If even length: bold first half
  - If odd length: bold first half + 1 character
  
  ## Examples
  
      iex> Transformer.boldify("Hello")
      "<b>Hel</b>lo"
      
      iex> Transformer.boldify("World")
      "<b>Wor</b>ld"
      
      iex> Transformer.boldify("test")
      "<b>te</b>st"
  """

  @doc """
  Transforms text to bionic reading format with HTML bold tags.
  
  ## Parameters
  
    * `text` - String to transform
    
  ## Returns
  
    * Transformed string with `<b>` tags around first half of each word
  """
  @spec boldify(String.t()) :: String.t()
  def boldify(text) when is_binary(text) do
    text
    |> String.trim()
    |> String.split(~r/\s+/, trim: true)
    |> Enum.map(&boldify_word/1)
    |> Enum.join(" ")
  end

  def boldify(_), do: ""

  @doc """
  Transforms a single word to bionic format.
  
  ## Parameters
  
    * `word` - Single word to transform
    
  ## Returns
  
    * Word with first half bolded
  """
  @spec boldify_word(String.t()) :: String.t()
  def boldify_word(word) when byte_size(word) == 0, do: word

  def boldify_word(word) do
    length = String.length(word)
    half = div(length, 2)

    # For odd length words, bold one extra character
    split_at = if rem(length, 2) == 0, do: half, else: half + 1

    {bold_part, rest} = String.split_at(word, split_at)
    "<b>#{bold_part}</b>#{rest}"
  end

  @doc """
  Calculate statistics for transformed text.
  
  ## Parameters
  
    * `text` - Original text
    
  ## Returns
  
    * Map with `:word_count` and `:char_count`
  """
  @spec stats(String.t()) :: %{word_count: integer(), char_count: integer()}
  def stats(text) when is_binary(text) do
    words = text |> String.trim() |> String.split(~r/\s+/, trim: true)

    %{
      word_count: length(words),
      char_count: String.length(text)
    }
  end

  def stats(_), do: %{word_count: 0, char_count: 0}
end
