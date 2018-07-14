defmodule AirdatesApi.Parser do
  @type show_line :: [id: binary(), date: binary(), title: binary()]

  @doc """
  Fetch data from website and parses it.
  """
  @spec parse() :: [show_line]
  def parse do
    AirdatesApi.Client.get_airdates()
    |> Floki.parse()
    |> Floki.find(".day")
    |> Enum.flat_map(&parse_line/1)
  end

  @spec parse_line(Floki.HTMLTree.t()) :: [show_line()]
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

  @spec dispatch(binary(), binary(), binary()) :: show_line
  defp dispatch(date, id, title) do
    # # TODO Send this to the GenServer Store
    [id: id, date: date, title: title]
  end
end
