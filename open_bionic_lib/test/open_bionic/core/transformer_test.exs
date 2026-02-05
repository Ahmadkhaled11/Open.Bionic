defmodule OpenBionic.Core.TransformerTest do
  use ExUnit.Case, async: true
  alias OpenBionic.Core.Transformer

  doctest Transformer

  describe "boldify/1" do
    test "returns empty string for empty input"  do
      assert Transformer.boldify("") == ""
    end

    test "handles single word with even length" do
      assert Transformer.boldify("word") == "<b>wo</b>rd"
      assert Transformer.boldify("test") == "<b>te</b>st"
      assert Transformer.boldify("Hello") == "<b>Hel</b>lo"
    end

    test "handles single word with odd length" do
      assert Transformer.boldify("world") == "<b>wor</b>ld"
      assert Transformer.boldify("cat") == "<b>ca</b>t"
      assert Transformer.boldify("a") == "<b>a</b>"
    end

    test "handles multiple words" do
      result = Transformer.boldify("Hello World")
      assert result == "<b>Hel</b>lo <b>Wor</b>ld"
    end

    test "handles extra whitespace" do
      result = Transformer.boldify("Hello  World")
      assert result == "<b>Hel</b>lo <b>Wor</b>ld"

      result = Transformer.boldify("  Hello World  ")
      assert result == "<b>Hel</b>lo <b>Wor</b>ld"
    end

    test "handles non-string input gracefully" do
      assert Transformer.boldify(nil) == ""
      assert Transformer.boldify(123) == ""
    end

    test "preserves all characters in word" do
      # Even length: 4 chars
      result = Transformer.boldify("test")
      assert String.replace(result, ~r/<\/?b>/, "") == "test"

      # Odd length: 5 chars
      result = Transformer.boldify("hello")
      assert String.replace(result, ~r/<\/?b>/, "") == "hello"
    end

    test "handles long text" do
      text = "The quick brown fox jumps over the lazy dog"
      result = Transformer.boldify(text)

      # Should contain all original words
      assert result =~ "fox"
      assert result =~ "dog"

      # Should contain bold tags
      assert result =~ "<b>"
      assert result =~ "</b>"
    end
  end

  describe "boldify_word/1" do
    test "handles even length words correctly" do
      assert Transformer.boldify_word("ab") == "<b>a</b>b"
      assert Transformer.boldify_word("abcd") == "<b>ab</b>cd"
    end

    test "handles odd length words correctly" do
      assert Transformer.boldify_word("abc") == "<b>ab</b>c"
      assert Transformer.boldify_word("abcde") == "<b>abc</b>de"
    end

    test "handles single character" do
      assert Transformer.boldify_word("a") == "<b>a</b>"
    end

    test "handles empty string" do
      assert Transformer.boldify_word("") == ""
    end
  end

  describe "stats/1" do
    test "calculates correct word count" do
      stats = Transformer.stats("Hello World")
      assert stats.word_count == 2
    end

    test "calculates correct character count" do
      stats = Transformer.stats("Hello World")
      assert stats.char_count == 11
    end

    test "handles empty string" do
      stats = Transformer.stats("")
      assert stats.word_count == 0
      assert stats.char_count == 0
    end

    test "handles extra whitespace" do
      stats = Transformer.stats("  Hello   World  ")
      assert stats.word_count == 2
    end

    test "handles non-string input" do
      stats = Transformer.stats(nil)
      assert stats.word_count == 0
      assert stats.char_count == 0
    end
  end
end
