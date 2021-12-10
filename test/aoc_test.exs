defmodule AOCTest do
  use ExUnit.Case

  @current_day 10
  @current_part 2
  @current_env :real

  for day <- 1..@current_day do
    day_str = day |> to_string() |> String.pad_leading(2, "0")

    describe "day #{day_str}" do
      max_part = if day == @current_day, do: @current_part, else: 2

      for part <- 1..max_part do
        envs =
          if day == @current_day and part == max_part and @current_env == :practice do
            [:practice]
          else
            [:practice, :real]
          end

        for env <- envs do
          @tag "#{day_str}": true
          @tag "#{env}": true
          @tag timeout: :infinity
          test "part #{part} #{env}" do
            day = unquote(day_str)
            part = unquote(part)
            env = unquote(env)
            solutions_module = Module.concat([AOC, Solutions, "Day#{day}"])
            solution = apply(solutions_module, :"part_#{part}", [unquote(env)])

            module = Module.concat([AOC, "Day#{day}"])

            file =
              case env do
                :practice -> "inputs/day_#{day}.test.txt"
                :real -> "inputs/day_#{day}.txt"
              end

            my_answer = apply(module, :"part_#{part}", [File.read!(file)])

            assert my_answer == solution
          end
        end
      end
    end
  end
end
