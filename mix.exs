defmodule Tracetalk.MixProject do
  use Mix.Project

  def project do
    [
      app: :tracetalk,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Tracetalk.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:redbug, "~> 2.0"},
      {:recon, "~> 2.3"},
      {:recon_ex, "~> 0.9.1"},
      {:edbg, "~> 0.9.5"},
      {:entrace, github: "lawik/entrace"}
    ]
  end
end
