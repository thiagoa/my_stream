defmodule PipeTest do
  use ExUnit.Case

  test "works with Enum.map" do
    assert [6, 10, 14, 18] == [1, 2, 3, 4]
    |> Pipe.map(&(&1 * 2))
    |> Pipe.map(&(&1 + 1))
    |> Enum.map(&(&1 * 2))
  end

  test "works with Enum.to_list" do
    assert [4, 6, 8, 10] == [1, 2, 3, 4]
    |> Pipe.map(&(&1 * 2))
    |> Pipe.map(&(&1 + 2))
    |> Enum.to_list
  end

  test "works with Enum.take" do
    assert [7, 9] == [1, 2, 3, 4]
    |> Pipe.map(&(&1 * 2))
    |> Pipe.map(&(&1 + 2))
    |> Pipe.map(&(&1 + 3))
    |> Enum.take(2)
  end

  test "works with a range" do
    assert [4, 6] == 1..4
    |> Pipe.map(&(&1 * 2))
    |> Pipe.map(&(&1 + 2))
    |> Enum.take(2)
  end

  test "works with string lists" do
    assert ["OLLEH", "DLROW"] == ["hello", "world"]
    |> Pipe.map(&(String.upcase/1))
    |> Pipe.map(&(String.reverse/1))
    |> Enum.to_list
  end
end
