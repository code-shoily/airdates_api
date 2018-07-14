defmodule AirdatesApi.Client do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://www.airdates.tv")
  plug(Tesla.Middleware.Compression, format: "gzip")

  @doc """
  Gets all data from the URL
  """
  def get_airdates do
    case get("/") do
      {:ok, %Tesla.Env{body: body}} -> body
      _ -> nil
    end
  end
end
