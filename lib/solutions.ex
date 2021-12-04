defmodule AOC.Solutions do
  defmodule Day01 do
    IO.inspect(__MODULE__)
    def part_1(:test), do: 7
    def part_1(:real), do: 1266
    def part_2(:test), do: 5
    def part_2(:real), do: 1217
  end

  defmodule Day02 do
    def part_1(:test), do: 150
    def part_1(:real), do: 1_561_344
    def part_2(:test), do: 900
    def part_2(:real), do: 1_848_454_425
  end

  defmodule Day03 do
    def part_1(:test), do: 198
    def part_1(:real), do: 3_009_600
    def part_2(:test), do: 230
    def part_2(:real), do: 6_940_518
  end

  defmodule Day04 do
    def part_1(:test), do: 4512
    def part_1(:real), do: 49686
    def part_2(:test), do: 1924
    def part_2(:real), do: 26878
  end
end
