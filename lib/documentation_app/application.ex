defmodule DocumentationApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DocumentationAppWeb.Telemetry,
      DocumentationApp.Repo,
      {DNSCluster, query: Application.get_env(:documentation_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DocumentationApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DocumentationApp.Finch},
      # Start a worker by calling: DocumentationApp.Worker.start_link(arg)
      # {DocumentationApp.Worker, arg},
      # Start to serve requests, typically the last entry
      DocumentationAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DocumentationApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DocumentationAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
