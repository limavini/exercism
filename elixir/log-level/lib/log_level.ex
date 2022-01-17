defmodule LogLevel do
  @logs [
    %{code: 0, label: :trace, legacy: false},
    %{code: 1, label: :debug, legacy: true},
    %{code: 2, label: :info, legacy: true},
    %{code: 3, label: :warning, legacy: true},
    %{code: 4, label: :error, legacy: true},
    %{code: 5, label: :fatal, legacy: false}
  ]
  def to_label(level, false) do
    Enum.find(@logs, fn
      %{code: ^level} ->
        true

      _ ->
        false
    end)
    |> maybe_unknown()
  end

  def to_label(level, true) do
    Enum.find(@logs, fn
      %{code: ^level, legacy: true} ->
        true

      _ ->
        false
    end)
    |> maybe_unknown()
  end

  defp maybe_unknown(log) do
    if log do
      log.label
    else
      :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    case to_label(level, legacy?) do
      label when label in [:error, :fatal] -> :ops
      :unknown when legacy? -> :dev1
      :unknown when not legacy? -> :dev2
      _ -> false
    end
  end
end
