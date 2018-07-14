defmodule AirdatesApi.Web.Schema do
  use Absinthe.Schema

  query do
    @desc "Hello World"
    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "World"} end)
    end
  end
end
