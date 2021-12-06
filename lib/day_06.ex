defmodule AOC.Day06 do
  use IceCream

  def part_1(input) do
    laternfish =
      input
      |> String.split(",")
      |> Stream.map(&String.to_integer/1)

    next_day(laternfish, 0, 80)
  end

  defp next_day(laternfish, current_day, until) when current_day == until,
    do: Enum.count(laternfish)

  defp next_day(laternfish, current_day, until) do
    IO.write("#{current_day}|")

    decreased =
      laternfish
      |> Stream.map(&(&1 - 1))

    new_laternfish =
      Stream.cycle([8])
      |> Stream.take(Enum.count(decreased, &(&1 < 0)))

    reset_negatives =
      Stream.map(decreased, fn el ->
        if el < 0, do: 6, else: el
      end)

    next_day(Stream.concat([reset_negatives, new_laternfish]), current_day + 1, until)
  end
end
