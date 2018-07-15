defmodule AirdatesApi.Web.Schema do
  use Absinthe.Schema
  alias AirdatesApi.Web.Resolvers

  import_types(AirdatesApi.Web.Types)

  query do
    @desc """
    Lists all shows. Can be filtered by id, seriesId, title, or date.
    Any of the three criteria can be filtered on. Episode can only be used with title
    """
    field :shows, list_of(:show) do
      arg(:id, :id, description: "The ID for the show airred on a particular date")
      arg(:series_id, :id, description: "The ID given by airdates.tv of the show")

      arg(
        :title,
        :string,
        description: "The title of the show, can be used together with 'episode'"
      )

      arg(:date, :string, description: "The date of the show, in YYYYMMDD format")
      arg(:episode, :string, description: "Episode in SXXEXX format")
      arg(:sort_by, :string, description: "Either 'title' or 'date', sort field for show list")
      resolve(&Resolvers.series/3)
    end
  end

  mutation do
    @desc "(Re-)fetches all shows from http://airdates.tv"
    field :reload, list_of(:show) do
      resolve(&Resolvers.reload/3)
    end
  end
end
