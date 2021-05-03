defmodule RotationalCipher do
  # <<97>> = a
  # <<122>> = z
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.map(&encode(&1, shift))
    |> Enum.join("")
  end

  defp encode(char, _shift) when char < ?A do
    <<char>>
  end

  defp encode(char, shift) when char > ?a - 1 do
    total = get_distance(char + shift)
    <<total>>
  end

  defp encode(char, shift) when char in ?A..?Z do
    total = get_distance_upper(char + shift)
    <<total>>
  end

  defp get_distance(total) when total > ?z do
    remaining = total - ?z
    get_distance(?a - 1 + remaining)
  end

  defp get_distance(total) do
    total
  end

  defp get_distance_upper(total) when total > ?Z do
    remaining = total - ?Z
    get_distance_upper(?A - 1 + remaining)
  end

  defp get_distance_upper(total) do
    total
  end
end
