defmodule AirdatesApi do
  @moduledoc """
  Documentation for AirdatesApi.
  """
  use Application

  def start(_type, _args) do
    AirdatesApi.Supervisor.start_link(name: AirdatesApi.Supervisor)
  end
end
