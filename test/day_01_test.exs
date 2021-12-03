defmodule AOC.Day01Test do
  use ExUnit.Case

  @aoc AOC.Day01

  @input """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  test "part 1 test" do
    assert @aoc.part_1(@input) == 7
  end

  test "part 1 real" do
    assert @aoc.part_1() == 1266
  end

  test "part 2 test" do
    assert @aoc.part_2(@input) == 5
  end

  test "part 2 real" do
    assert @aoc.part_2() == 1217
  end
end
