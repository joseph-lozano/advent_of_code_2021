defmodule AOC.Day02 do
  def part_1(input \\ nil) do
    {x, y} =
      input
      |> get_input()
      |> Enum.reduce({0, 0}, fn [dir, amt], {x, y} ->
        case dir do
          :forward -> {x + amt, y}
          :down -> {x, y + amt}
          :up -> {x, y - amt}
        end
      end)

    x * y
  end

  def part_2(input \\ nil) do
    {_aim, x, y} =
      input
      |> get_input()
      |> Enum.reduce({0, 0, 0}, fn [cmd, amt], {aim, x, y} ->
        case cmd do
          :forward -> {aim, x + amt, y + aim * amt}
          :down -> {aim + amt, x, y}
          :up -> {aim - amt, x, y}
        end
      end)

    x * y
  end

  defp get_input(nil) do
    File.read!("inputs/day_02.txt")
    |> normalize()
  end

  defp get_input(input) when is_binary(input) do
    input
    |> normalize()
  end

  defp normalize(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(fn str ->
      [dir, amount] = String.split(str, " ")
      [String.to_existing_atom(dir), String.to_integer(amount)]
    end)
  end
end
