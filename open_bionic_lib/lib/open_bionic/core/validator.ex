defmodule OpenBionic.Core.Validator do
  @moduledoc """
  Input validation for text transformation requests.
  """

  @max_length Application.compile_env(:open_bionic, :max_text_length, 100_000)

  @doc """
  Validates input text for transformation.
  
  ## Rules
  
  - Text cannot be empty
  - Text cannot exceed #{@max_length} characters
  - Text must be a string
  
  ## Returns
  
  - `{:ok, text}` if valid
  - `{:error, reason}` if invalid
  """
  @spec validate_text(any()) :: {:ok, String.t()} | {:error, atom()}
  def validate_text(text) when not is_binary(text) do
    {:error, :invalid_type}
  end

  def validate_text(text) when byte_size(text) == 0 do
    {:error, :empty_text}
  end

  def validate_text(text) do
    char_count = String.length(text)

    if char_count > @max_length do
      {:error, :text_too_long}
    else
      {:ok, text}
    end
  end

  @doc """
  Gets human-readable error message for validation errors.
  """
  @spec error_message(atom()) :: String.t()
  def error_message(:invalid_type), do: "Input must be a string"
  def error_message(:empty_text), do: "Text cannot be empty"
  def error_message(:text_too_long), do: "Text exceeds maximum length of #{@max_length} characters"
  def error_message(_), do: "Invalid input"
end
