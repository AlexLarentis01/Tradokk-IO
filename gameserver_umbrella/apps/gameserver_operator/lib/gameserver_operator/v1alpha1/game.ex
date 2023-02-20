defmodule GameserverOperator.API.V1Alpha1.Game do
  @moduledoc """
  GameserverOperator: Game CRD V1Alpha1 version.

  Modify the `manifest/0` function in order to override the defaults,
  e.g. to define an openAPIV3 schema, add subresources or additional
  printer columns:

  ```

  ```
  """


  use Bonny.API.Version,
    hub: true

  def manifest() do
    struct!(
      defaults(),
      name: "v1alpha1",
      schema: %{
        openAPIV3Schema: %{
          type: :object,
          properties: %{
            spec: %{
              type: :object,
              properties: %{
                foos: %{type: :integer}
              }
            },
            status: %{

            }
          }
        }
      },
      additionalPrinterColumns: [
        %{name: "foos", type: :integer, description: "Number of foos", jsonPath: ".spec.foos"}
      ],
      subresources: %{
        status: %{}
      }
    )
  end

  @impl true
  def manifest() do
    defaults()
    |> struct!(name: "v1alpha1")
    |> add_observed_generation_status()
  end
end
