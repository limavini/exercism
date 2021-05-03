defmodule RomanNumerals do
  @values [{1, "I"}, {5, "V"}, {10, "X"}, {50, "L"}, {100, "C"}, {500, "D"}, {1000, "M"}]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    find_default(number)
    |> transform()
  end

  defp find_default(number) do
    {_, character} =
      Enum.find(@values, {0, number}, fn {value, _character} -> value == number end)

    character
  end

  defp transform(number) when is_binary(number) do
    number
  end

  defp transform(number) when number < 5 do
    String.duplicate("I", number)
  end

  defp transform(number) when number < 10 do
  end
end
