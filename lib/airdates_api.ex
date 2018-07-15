defmodule AirdatesApi do
  @moduledoc """
  Documentation for AirdatesApi.
  """
  use Application

  def start(_type, _args) do
    children = [
      {AirdatesApi.SeriesStore, name: :store},
      Plug.Adapters.Cowboy2.child_spec(
        scheme: :http,
        plug: AirdatesApi.Web.Router,
        options: [port: 4001]
      )
    ]

    opts = [strategy: :one_for_one, name: AirdatesApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
