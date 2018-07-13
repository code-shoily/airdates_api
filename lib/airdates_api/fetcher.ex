defmodule AirdatesApi.Fetcher do
  @moduledoc """
  Contains functions for helper functions.
  """
  alias AirdatesApi.Client

  @doc """
  Returns the URL used for scraping
  """
  @spec url() :: String.t()
  def url do
    Application.get_env(:airdates_api, :url)
  end

  def curl() do
    try do
      Client.get_airdates()
      |> :zlib.gunzip()
    rescue
      ArgumentError -> nil
    end
  end
end
