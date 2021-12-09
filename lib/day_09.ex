defmodule AOC.Day09 do
  defmodule Cell do
    defstruct [:value, :position, neighbors: []]
  end

  def part_1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(fn row ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {el, idx} ->
        value = to_integer(el)
        left_neighbor = if idx > 0, do: Enum.at(row, idx - 1) |> to_integer()
        right_neighbor = Enum.at(row, idx + 1) |> to_integer()

        %Cell{value: value, neighbors: [left_neighbor, right_neighbor]}
      end)
    end)
    |> Enum.zip_with(& &1)
    |> Enum.map(fn col ->
      col
      |> Enum.with_index()
      |> Enum.map(fn {el, idx} ->
        up_neighbor = if idx > 0, do: Enum.at(col, idx - 1) |> to_integer()
        down_nieghbor = Enum.at(col, idx + 1) |> to_integer()

        update_in(el.neighbors, fn neighbors ->
          [up_neighbor, down_nieghbor] ++ neighbors
        end)
      end)
    end)
    |> Enum.zip_with(& &1)
    |> List.flatten()
    |> Enum.filter(fn cell ->
      cell.value < Enum.min(cell.neighbors)
    end)
    |> Enum.reduce(0, fn cell, acc ->
      cell.value + acc + 1
    end)
  end

  defp to_integer(int) when is_integer(int), do: int
  defp to_integer(nil), do: nil
  defp to_integer({el, _idx}) when is_binary(el), do: String.to_integer(el)
  defp to_integer(el) when is_binary(el), do: String.to_integer(el)
  defp to_integer(%Cell{value: value}), do: value

  def part_2(input) do
    cells =
      input
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, x} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {el, y} ->
          value = to_integer(el)

          %Cell{
            value: value,
            position: {x, y},
            neighbors:
              [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
              |> Enum.reject(fn {nx, ny} -> nx < 0 or ny < 0 end)
          }
        end)
      end)

    Enum.reduce(cells, %{}, fn cell, acc ->
      # acc is a map of cell => [cell] where the key is the basin low point, and the value is a list of cells leading to it

      if cell in List.flatten(Map.values(acc)) or cell.value == 9 do
        acc
      else
        {basin, followed_cells} = follow(cell, cells)

        update_in(acc, [Access.key(basin, [])], &((&1 ++ followed_cells) |> Enum.uniq()))
      end
    end)
    |> Enum.map(fn {_basin, followed} ->
      # plus one to include the basin
      Enum.count(followed) + 1
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  defp follow(cell, all_cells, followed_cells \\ []) do
    min =
      cell.neighbors
      |> Enum.map(fn neighbor -> Enum.find(all_cells, &(&1.position == neighbor)) end)
      |> Enum.min_by(fn
        nil -> nil
        cell -> cell.value
      end)

    is_basin? = cell.value < min.value

    if is_basin? do
      {cell, followed_cells}
    else
      follow(min, all_cells, [cell | followed_cells])
    end
  end
end
