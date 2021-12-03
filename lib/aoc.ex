defmodule AOC do
  def run do
    Enum.each(1..1, fn i ->
      day = String.pad_leading(to_string(i), 2, "0")

      :"Elixir.AOC.Day#{day}".part_1()
      |> IO.inspect(label: "Day #{day}, part 1")

      :"Elixir.AOC.Day#{day}".part_2()
      |> IO.inspect(label: "Day #{day}, part 2")
    end)
  end
end
