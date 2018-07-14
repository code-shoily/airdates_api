defmodule AirdatesApi.Web.Router do
  use Plug.Router

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  # forward(
  #   "/api",
  #   to: Absinthe.Plug,
  #   init_opts: [schema: AirdatesApi.Web.Schema]
  # )

  forward(
    # "/graphql" if we want to write app after uncommenting the snippets above
    "/",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: AirdatesApi.Web.Schema,
      interface: :playground
    ]
  )
end
