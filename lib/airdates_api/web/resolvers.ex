defmodule AirdatesApi.Web.Resolvers do
  alias AirdatesApi.SeriesStore, as: Store

  @spec series(any(), map(), any()) :: {:ok, any()} | {:error, any()}
  def series(_, args, _) do
    {episode, arg} = Map.pop(args, :episode)

    case {episode, Map.keys(arg)} do
      {nil, []} ->
        {:ok, Store.list(:store)}

      {_, [:title]} ->
        {:ok, Store.find_by_title(:store, arg[:title], episode)}

      {nil, [:id]} ->
        {:ok, Store.find_by_id(:store, args[:id])}

      {nil, [:series_id]} ->
        {:ok, Store.find_by_series_id(:store, args[:series_id])}

      {nil, [:date]} ->
        {:ok, Store.find_by_date(:store, args[:date])}

      {nil, [:sort_by]} ->
        {:ok, Store.list(:store, sort: arg[:sort_by])}

      {_, [_]} ->
        {:error, "Episode should only be used with title"}

      _ ->
        {:error, "One of id, title, seriesId, date or sortBy should be used for query"}
    end
  end

  def reload(_, _, _) do
    {:ok, Store.reload(:store)}
  end
end
