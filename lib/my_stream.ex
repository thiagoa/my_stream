defmodule Pipe do
  defmodule Data, do: defstruct [:enum, :funcs]

  def map(%Data{} = data, func), do: Map.update!(data, :funcs, &(&1 ++ [func]))
  def map(enum, func), do: %Data{enum: enum, funcs: [func]}
end

defimpl Enumerable, for: Pipe.Data do
  def count(_), do: {:error, __MODULE__}
  def member?(_, _), do: {:error, __MODULE__}

  def reduce(%{enum: enum, funcs: funcs}, acc, mapper) do
    do_reduce enum, pipe(funcs), acc, mapper
  end

  defp do_reduce(enum, func, acc, mapper) do
    Enumerable.reduce(enum, acc, &(&1 |> func.() |> mapper.(&2)))
  end

  defp pipe(funcs) do
    Enum.reduce(funcs, &(&1), &(fn(x) -> x |> &2.() |> &1.() end))
  end
end
