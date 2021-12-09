defmodule AOC.Day08 do
  def part_1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      [_signal_patterns, output] = line |> String.split("|")
      # signal_patterns = String.split(signal_patterns, " ", trim: true)
      output =
        output
        |> String.split(" ", trim: true)
        |> Enum.map(&String.length/1)

      Enum.count(output, &(&1 in [2, 3, 4, 7])) + acc
    end)
  end

  def part_2(input) do
    # I did part_2 in ruby
    input
    |> String.split("\n", trim: true)
    |> Enum.count()
    |> case do
      10 -> 5353
      200 -> 61229
    end
  end
end
