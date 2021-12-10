defmodule AOC.Day10 do
  @scores %{
    ?) => 3,
    ?] => 57,
    ?} => 1197,
    ?> => 25137
  }
  @invalid_chars Map.keys(@scores)
  def part_1(input) do
    input
    |> parse
    |> Enum.reduce(0, &(get_score(&1, 1) + &2))
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_charlist/1)
  end

  defp get_score(line, part) do
    line
    |> Enum.reduce_while([], fn char, stack ->
      if char in '([{<' do
        {:cont, push(stack, char)}
      else
        {popped, new_stack} = pop(stack)

        if matches?(char, popped), do: {:cont, new_stack}, else: {:halt, {:corrupt, char}}
      end
    end)
    |> get_score_for_part(part)
  end

  defp get_score_for_part(data, 1 = _part) do
    data
    |> case do
      {:corrupt, char} when char in @invalid_chars -> Map.get(@scores, char)
      _ -> 0
    end
  end

  defp matches?(?), ?(), do: true
  defp matches?(?(, ?)), do: true
  defp matches?(?], ?[), do: true
  defp matches?(?[, ?]), do: true
  defp matches?(?}, ?{), do: true
  defp matches?(?{, ?}), do: true
  defp matches?(?>, ?<), do: true
  defp matches?(?<, ?>), do: true
  defp matches?(_, _), do: false

  defp push(stack, char) do
    [char | stack]
  end

  defp pop([head | tail]) do
    {head, tail}
  end
end
