defmodule GameserverOperatorTest do
  use ExUnit.Case
  doctest GameserverOperator

  test "greets the world" do
    assert GameserverOperator.hello() == :world
  end
end
