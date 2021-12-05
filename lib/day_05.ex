defmodule AOC.Day05 do
  def part_1(input) do
    input
    |> get_lines()
    |> Enum.reduce(%{}, fn line, acc ->
      fill_line(acc, line, false)
    end)
    |> Enum.count(fn {_point, val} -> val >= 2 end)
  end

  def part_2(input) do
    input
    |> get_lines()
    |> Enum.reduce(%{}, fn line, acc ->
      fill_line(acc, line, true)
    end)
    |> Enum.count(fn {_point, val} -> val >= 2 end)
  end

  def get_lines(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, " -> ")
      |> Enum.map(fn point ->
        String.split(point, ",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
    end)
  end

  defp fill_line(points_map, [{x, y1}, {x, y2}], _) do
    Enum.reduce(y1..y2, points_map, fn y, acc ->
      Map.update(acc, {x, y}, 1, &(&1 + 1))
    end)
  end

  defp fill_line(points_map, [{x1, y}, {x2, y}], _) do
    Enum.reduce(x1..x2, points_map, fn x, acc ->
      Map.update(acc, {x, y}, 1, &(&1 + 1))
    end)
  end

  defp fill_line(points_map, _, false) do
    points_map
  end

  defp fill_line(points_map, [{x1, y1}, {x2, y2}], true) do
    [x_sign, y_sign] = [get_sign(x2 - x1), get_sign(y2 - y1)]
    times = abs(x2 - x1)

    Enum.reduce(0..times, points_map, fn time, acc ->
      Map.update(acc, {x1 + time * x_sign, y1 + time * y_sign}, 1, &(&1 + 1))
    end)
  end

  defp get_sign(integer) when integer < 0, do: -1
  defp get_sign(integer) when integer > 0, do: 1
  defp get_sign(integer) when integer == 0, do: 0
end
