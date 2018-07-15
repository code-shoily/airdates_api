defmodule AirdatesApi.Parser do
  @type show_line :: %{
          id: binary(),
          series_id: binary(),
          date: binary(),
          slug: binary(),
          title: binary()
        }

  @doc """
  Fetch data from website and parses it.
  """
  @spec parse() :: [show_line]
  def parse do
    IO.puts("Airdates Parsed")

    AirdatesApi.Client.get_airdates()
    |> Floki.parse()
    |> Floki.find(".day")
    |> Enum.flat_map(&parse_line/1)
  end

  @spec parse_line(Floki.HTMLTree.t()) :: [show_line()]
  defp parse_line({_, [_, {"data-date", date}], data}) do
    data
    |> Enum.map(fn
      {_, [{_, "entry"}, {"data-series-id", series_id}, {"data-series-source", slug}],
       [{_, [{_, "title"}], [title]}]} ->
        dispatch(date, UUID.uuid4(), series_id, slug, title)

      _ ->
        nil
    end)
    |> Enum.filter(& &1)
  end

  @spec dispatch(binary(), binary(), binary(), binary(), binary()) :: show_line
  defp dispatch(date, id, series_id, slug, title) do
    %{id: id, series_id: series_id, date: date, slug: slug, title: title}
  end
end
