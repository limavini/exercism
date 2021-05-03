defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    transcode(rna, 0, [])
  end

  defp transcode(rna, start_at, list) do
    {status, new_list} =
      String.slice(rna, start_at, 3)
      |> of_codon()
      |> add_to_list(list)

    continue(rna, start_at + 3, new_list, status)
  end

  defp continue(_rna, _start_at, list, :stop) do
    {:ok, Enum.reverse(list)}
  end

  defp continue(rna, start_at, list, :continue) do
    transcode(rna, start_at, list)
  end

  defp continue(_rna, _start_at, _list, :error) do
    {:error, "invalid RNA"}
  end

  defp add_to_list({:error, _message}, list) do
    {:error, list}
  end

  defp add_to_list({:ok, "STOP"}, list) do
    {:stop, list}
  end

  defp add_to_list({:ok, protein}, list) do
    {:continue, [protein | list]}
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU => Cysteine
  UGC => Cysteine
  UUA => "Leucine
  UUG => "Leucine
  AUG => "Methionine
  UUU => "Phenylalanine
  UUC => "Phenylalanine
  UCU => "Serine
  UCC => "Serine
  UCA => "Serine
  UCG => "Serine
  UGG => "Tryptophan
  UAU => "Tyrosine
  UAC => "Tyrosine
  UAA => "STOP
  UAG => "STOP
  UGA => "STOP
  """
  def of_codon("") do
    {:ok, "STOP"}
  end

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    display_value(@proteins[codon])
  end

  def display_value(nil) do
    {:error, "invalid codon"}
  end

  def display_value(value) do
    {:ok, value}
  end
end
