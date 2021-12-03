defmodule AOC.Day02Test do
  use ExUnit.Case

  @aoc AOC.Day02

  @input """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  test "part 1 test" do
    assert @aoc.part_1(@input) == 150
  end

  test "part 1 real" do
    assert @aoc.part_1() == 1_561_344
  end

  test "part 2 test" do
    assert @aoc.part_2(@input) == 900
  end

  test "part 2 real" do
    assert @aoc.part_2() == 1_848_454_425
  end
end
