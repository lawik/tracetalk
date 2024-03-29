defmodule Tracetalk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      pg_spec(),
      Tracetalk.Sampler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tracetalk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp pg_spec do
    %{
      id: :pg,
      start: {:pg, :start_link, []}
    }
  end
end
