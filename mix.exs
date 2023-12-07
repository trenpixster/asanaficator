defmodule Asanaficator.Mixfile do
  use Mix.Project

  Code.compiler_options(on_undefined_variable: :warn)
  @description """
    Simple Elixir wrapper for the Asana API
  """

  def project do
    [ app: :asanaficator,
      version: "0.0.2",
      elixir: "~> 1.0",
      name: "Asanaficator",
      description: @description,
      package: package(),
      deps: deps() ]
  end

  def application do
    [ applications: [ :httpoison, :exjsx ] ]
  end

  defp deps do
   [ { :httpoison, "~> 0.6.0" },
     { :exjsx, "~> 3.0" },
     { :meck, "~> 0.8.2", only: :test },
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.7", only: :dev} ]
  end

  defp package do
    [ contributors: ["Nizar Venturini"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/trenpixster/asanaficator" } ]
  end
end
