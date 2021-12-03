defmodule AOC.Day03 do
  def part_1(input \\ nil) do
    [gamma: gamma, epsilon: epsilon] =
      get_input(input)
      |> transpose()
      |> Enum.reduce([gamma: "", epsilon: ""], fn col, acc ->
        gamma = calc_frequency(:gamma, col)
        epsilon = calc_frequency(:epsilon, col)

        Keyword.update!(acc, :gamma, &(&1 <> "#{gamma}"))
        |> Keyword.update!(:epsilon, &(&1 <> "#{epsilon}"))
      end)
      |> Enum.map(fn {key, binary_string} -> {key, String.to_integer(binary_string, 2)} end)

    gamma * epsilon
  end

  def part_2(input \\ nil) do
    input = get_input(input)

    oxygen_generator_rating = get_rating(input, :oxygen_generator, 0)
    co2_scrubber_rating = get_rating(input, :co2_scrubber, 0)
    oxygen_generator_rating * co2_scrubber_rating
  end

  defp get_input(nil) do
    File.read!("inputs/day_03.txt")
    |> normalize()
  end

  defp get_input(input) when is_binary(input) do
    input
    |> normalize()
  end

  defp normalize(input) when is_binary(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&split_to_integer/1)
  end

  defp split_to_integer(binary_string) do
    binary_string
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def calc_frequency(freq, row) do
    func =
      case freq do
        :gamma -> &Enum.max_by/2
        :epsilon -> &Enum.min_by/2
      end

    Enum.frequencies(row)
    |> func.(&elem(&1, 1))
    |> elem(0)
  end

  def get_rating(input, thing, x \\ 0)

  def get_rating([row], _, _) do
    row
    |> Enum.join()
    |> String.to_integer(2)
  end

  def get_rating(input, thing, x) do
    func =
      case thing do
        :oxygen_generator -> &most_common/2
        :co2_scrubber -> &least_common/2
      end

    most_or_least_common_in_x_row =
      transpose(input)
      |> func.(x)

    fit_criteria =
      Enum.filter(input, fn row ->
        Enum.at(row, x) == most_or_least_common_in_x_row
      end)

    get_rating(fit_criteria, thing, x + 1)
  end

  def most_common(transposed, x) do
    list = Enum.at(transposed, x)
    if Enum.count(list, &(&1 == 0)) > Enum.count(list, &(&1 == 1)), do: 0, else: 1
  end

  def least_common(transposed, x) do
    list = Enum.at(transposed, x)

    if Enum.count(list, &(&1 == 1)) < Enum.count(list, &(&1 == 0)), do: 1, else: 0
  end
end
