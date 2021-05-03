defmodule RnaTranscription do
  def transcribe(?G) do
    ?C
  end

  def transcribe(?C) do
    ?G
  end

  def transcribe(?T) do
    ?A
  end

  def transcribe(?A) do
    ?U
  end

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &transcribe/1)
  end

  def to_rna() do
    IO.puts("Unsupported character")
  end
end
