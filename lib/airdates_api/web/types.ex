defmodule AirdatesApi.Web.Types do
  use Absinthe.Schema.Notation

  enum :sort_fields do
    value(:title)
    value(:date)
  end

  object :show do
    field(:id, :id)
    field(:date, :string)
    field(:series_id, :string)
    field(:description, :string)
    field(:title, :string)
  end
end
