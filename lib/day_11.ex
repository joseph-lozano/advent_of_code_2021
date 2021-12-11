defmodule AOC.Day11 do
  def part_1(input) do
    grid = grid(input)

    Enum.reduce(1..100, {grid, 0}, fn _step_num, {grid, flashes} ->
      {grid, new_flashes} = execute_step(grid)
      {grid, new_flashes + flashes}
    end)
    |> elem(1)
  end

  def part_2(input) do
    grid = grid(input)
    do_part_2(grid, 1)
  end

  defp do_part_2(grid, step) do
    {new_grid, new_flashes} = execute_step(grid)

    if new_flashes == 100 do
      step
    else
      do_part_2(new_grid, step + 1)
    end
  end

  defp grid(input) do
    lines =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        row
        |> String.split("", trim: true)
        |> Enum.with_index()
      end)
      |> Enum.with_index()

    for {row, y} <- lines, {el, x} <- row, into: %{} do
      {{x, y}, String.to_integer(el)}
    end
  end

  defp execute_step(grid) do
    # First, the energy level of each octopus increases by 1.
    grid = Map.map(grid, fn {_k, v} -> v + 1 end)

    flash(grid)
  end

  defp flash(grid, flashes \\ 0) do
    # Then, any octopus with an energy level greater than 9 flashes. This increases the energy level of all adjacent octopuses by 1, including octopuses that are diagonally adjacent. If this causes an octopus to have an energy level greater than 9, it also flashes. This process continues as long as new octopuses keep having their energy level increased beyond 9. (An octopus can only flash at most once per step.)
    {new_grid, flashes} =
      case Enum.filter(grid, fn {_k, v} -> v > 9 end) do
        [] ->
          {grid, flashes}

        flashed ->
          # if length(flashed) > 20, do: raise("oops")

          new_grid =
            flashed
            |> Enum.reduce(grid, fn {{x, y}, _}, grid ->
              for i <- (x - 1)..(x + 1), j <- (y - 1)..(y + 1) do
                {i, j}
              end
              |> Enum.reduce(grid, fn {x, y}, grid ->
                if Map.has_key?(grid, {x, y}) do
                  Map.update!(grid, {x, y}, &plus_one(&1))
                else
                  grid
                end
              end)
              |> Map.put({x, y}, -1)
            end)

          flash(new_grid, flashes + Enum.count(grid, fn {_, v} -> v > 9 end))
      end

    new_grid = Map.map(new_grid, fn {_, v} -> if v < 0, do: 0, else: v end)
    {new_grid, flashes}
  end

  defp plus_one(x) when x < 0, do: x - 1
  defp plus_one(x), do: x + 1
end
