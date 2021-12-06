defmodule AOC.Day06 do
  def part_1(input) do
    laternfish =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    next_day(laternfish, 0, 80)
  end

  def part_2(input) do
    laternfish =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    next_day(laternfish, 0, 256)
  end

  defp next_day(laternfish, current_day, until) when current_day == until,
    do: Enum.reduce(laternfish, 0, fn {_key, val}, acc -> val + acc end)

  defp next_day(laternfish, current_day, until) do
    decreased =
      Enum.map(laternfish, fn {key, val} ->
        {key - 1, val}
      end)
      |> Enum.into(%{})

    {negatives, decreased} = Map.pop(decreased, -1, 0)

    new_laternfish =
      Map.put(decreased, 8, negatives)
      |> Map.update(6, negatives, &(&1 + negatives))

    next_day(new_laternfish, current_day + 1, until)
  end
end
