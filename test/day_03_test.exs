defmodule AOC.Day03Test do
  use ExUnit.Case

  @aoc AOC.Day03

  @input """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  test "part 1 test" do
    assert @aoc.part_1(@input) == 198
  end

  test "part 1 real" do
    assert @aoc.part_1() == 3_009_600
  end

  test "part 2 test" do
    assert @aoc.part_2(@input) == 230
  end

  test "part 2 real" do
    assert @aoc.part_2() == 6_940_518
  end
end
