defmodule AirdatesApi.Fetcher do
  @moduledoc """
  Contains functions for helper functions.
  """

  @doc """
  Returns the URL used for scraping
  """
  @spec url() :: String.t()
  def url do
    Application.get_env(:airdates_api, :url)
  end
end
