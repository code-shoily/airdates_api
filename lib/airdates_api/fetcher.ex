defmodule AirdatesApi.Fetcher do
  @moduledoc """
  Contains functions for helper functions.
  """
  alias AirdatesApi.Client

  def curl() do
    try do
      Client.get_airdates()
      |> :zlib.gunzip()
    rescue
      ArgumentError -> nil
    end
  end
end
