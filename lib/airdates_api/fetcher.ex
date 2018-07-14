defmodule AirdatesApi.Fetcher do
  @moduledoc """
  Contains functions for helper functions.
  """
  alias AirdatesApi.Client

  def curl() do
    Client.get_airdates()
  end
end
