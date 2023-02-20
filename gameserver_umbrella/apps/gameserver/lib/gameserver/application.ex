defmodule Gameserver.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Gameserver.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gameserver.PubSub}
      # Start a worker by calling: Gameserver.Worker.start_link(arg)
      # {Gameserver.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Gameserver.Supervisor)
  end
end
