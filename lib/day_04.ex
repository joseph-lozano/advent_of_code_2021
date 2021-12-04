defmodule AOC.Day04 do
  defmodule Cell do
    defstruct [:value, called: false]
  end

  def part_1(input) do
    {numbers, boards} = get_numbers_and_boards(input)

    Enum.reduce_while(numbers, boards, fn number, current_state ->
      new_boards = update_boards(current_state, number)

      case Enum.find(new_boards, &detect_winner/1) do
        nil -> {:cont, new_boards}
        board -> {:halt, number * board_value(board)}
      end
    end)
  end

  def part_2(input) do
    {numbers, boards} = get_numbers_and_boards(input)

    Enum.reduce_while(numbers, boards, fn number, current_state ->
      new_boards = update_boards(current_state, number)

      case new_boards do
        [one_left] ->
          if detect_winner(one_left),
            do: {:halt, number * board_value(one_left)},
            else: {:cont, [one_left]}

        _many_left ->
          {:cont, Enum.reject(new_boards, &detect_winner/1)}
      end
    end)
  end

  def get_numbers_and_boards(input) do
    [numbers | boards] =
      input
      |> String.split("\n\n", trim: true)

    numbers = numbers |> String.split(",") |> Enum.map(&String.to_integer(&1))

    boards =
      boards
      |> Enum.map(fn board ->
        String.split(board, "\n")
        |> Enum.map(fn row ->
          String.split(row, " ", trim: true)
          |> Enum.map(fn num ->
            %Cell{value: String.to_integer(num)}
          end)
        end)
      end)

    {numbers, boards}
  end

  def update_boards(boards, number) do
    Enum.map(boards, fn board ->
      Enum.map(board, fn row ->
        Enum.map(row, fn cell ->
          update_in(cell.called, fn
            true -> true
            false -> number == cell.value
          end)
        end)
      end)
    end)
  end

  def detect_winner(board) do
    transposed = Enum.zip_with(board, & &1)

    Enum.any?(board, fn row ->
      Enum.all?(row, & &1.called)
    end) or
      Enum.any?(transposed, fn col ->
        Enum.all?(col, & &1.called)
      end)
  end

  def board_value(board) do
    board
    |> List.flatten()
    |> Enum.reduce(0, fn cell, value ->
      if cell.called, do: value, else: value + cell.value
    end)
  end
end
