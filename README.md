# AirdatesApi

A simple program that fetches the data from [airdates.tv](http://airdates.tv), parses the data and puts it in a GraphQL queriable format.

# TODO

- Parse Season/Episode from title 
- GenServer to store all the fetched data
- GraphQL API to query the data from GenServer
- graphiql to interface with the API
- [Optional] Persist to database
- [Optional] Add favorite shows/set alarms

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `airdates_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:airdates_api, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/airdates_api](https://hexdocs.pm/airdates_api).

