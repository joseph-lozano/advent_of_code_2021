defmodule AOC.Day07 do
  def part_1(input) do
    positions =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    {min, max} = Enum.min_max(positions)

    Enum.map(min..max, fn position ->
      Enum.reduce(positions, 0, &(abs(position - &1) + &2))
    end)
    |> Enum.min()
  end

  def part_2(input) do
    positions =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    {min, max} = Enum.min_max(positions)

    Enum.map(min..max, fn position ->
      Enum.reduce(positions, 0, &(abs(get_fuel(position, &1)) + &2))
    end)
    |> Enum.min()
  end

  defp get_fuel(from, to) do
    n = abs(from - to)
    div(n * (n + 1), 2)
  end
end
