defmodule GameserverOperator.Controller.GameControllerTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use Bonny.Axn.Test

  alias GameserverOperator.Controller.GameController

  test "add is handled and returns axn" do
    axn = axn(:add)
    result = GameController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end

  test "modify is handled and returns axn" do
    axn = axn(:modify)
    result = GameController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end

  test "reconcile is handled and returns axn" do
    axn = axn(:reconcile)
    result = GameController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end

  test "delete is handled and returns axn" do
    axn = axn(:delete)
    result = GameController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end
end
