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

  forward(
    "/",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: AirdatesApi.Web.Schema,
      interface: :playground
    ]
  )
end
