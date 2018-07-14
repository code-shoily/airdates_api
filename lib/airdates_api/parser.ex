defmodule AirdatesApi.Parser do
  @doc """
  Fetch data from website and parses it.
  """
  @spec parse() :: [{binary(), binary(), binary()}]
  def parse do
    AirdatesApi.Client.get_airdates()
    |> Floki.parse()
    |> Floki.find(".day")
    |> Enum.flat_map(&parse_line/1)
  end

  @spec parse_line(Floki.HTMLTree.t()) :: [
          id: binary(),
          date: binary(),
          title: binary()
        ]
  defp parse_line({_, [_, {"data-date", date}], data}) do
    data
    |> Enum.map(fn
      {_, [{_, "entry"}, {"data-series-id", series_id}, _], [{_, [{_, "title"}], [title]}]} ->
        dispatch(date, series_id, title)

      _ ->
        nil
    end)
    |> Enum.filter(& &1)
  end

  @spec dispatch(binary(), binary(), binary()) :: [id: binary(), date: binary(), title: binary()]
  defp dispatch(date, id, title) do
    # # TODO Send this to the GenServer Store
    [id: id, date: date, title: title]
  end
end
