defmodule AirdatesApi.Web.Schema do
  use Absinthe.Schema
  alias AirdatesApi.Web.Resolvers

  import_types(AirdatesApi.Web.Types)

  query do
    @desc "Lists all shows"
    field :shows, list_of(:show) do
      arg(:id, :id)
      arg(:series_id, :id)
      arg(:title, :string)
      arg(:date, :string)
      arg(:episode, :string)
      arg(:sort_by, :string)
      resolve(&Resolvers.series/3)
    end
  end

  mutation do
    @desc "Fetches all shows from http://airdates.tv"
    field :reload, list_of(:show) do
      resolve(&Resolvers.reload/3)
    end
  end
end
