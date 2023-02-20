defmodule GameserverOperator.Operator do
  @moduledoc """
  Defines the operator.

  The operator resource defines custom resources, watch queries and their
  controllers and serves as the entry point to the watching and handling
  processes.
  """

  use Bonny.Operator, default_watch_namespace: "default"

  step(Bonny.Pluggable.Logger, level: :info)
  step(:delegate_to_controller)
  step(Bonny.Pluggable.ApplyStatus)
  step(Bonny.Pluggable.ApplyDescendants)

  @impl Bonny.Operator
  def controllers(watching_namespace, _opts) do
    [
      %{
        query:
          K8s.Client.list("tradokkio-operator.tradokk.io/v1alpha1", "Game",
            namespace: watching_namespace
          ),
        controller: GameserverOperator.Controller.GameController
      }
    ]
  end

  @impl Bonny.Operator
  def crds() do
    [
      %Bonny.API.CRD{
        names: %{kind: "Game", plural: "games", shortNames: [], singular: "game"},
        group: "tradokkio-operator.tradokk.io",
        versions: [GameserverOperator.API.V1Alpha1.Game],
        scope: :Namespaced
      }
    ]
  end
end
