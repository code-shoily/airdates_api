defmodule AirdatesApi.Parser do
  @typep show_line :: %{
           id: binary(),
           series_id: binary(),
           date: binary(),
           description: binary(),
           title: binary()
         }

  defp format_date(<<year::bytes-size(4), month::bytes-size(2), day::bytes-size(2)>>) do
    "#{year}-#{month}-#{day}"
  end

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
      {_, [{_, "entry"}, {"data-series-id", series_id}, {"data-series-source", description}],
       [{_, [{_, "title"}], [title]}]} ->
        %{
          id: UUID.uuid4(),
          series_id: series_id,
          date: format_date(date),
          description: description,
          title: title
        }

      _ ->
        nil
    end)
    |> Enum.filter(& &1)
  end
end
