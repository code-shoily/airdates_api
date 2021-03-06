# AirdatesApi

A simple program that fetches the data from [airdates.tv](http://airdates.tv), parses the data and puts it in a GraphQL queriable format.

## Usage

### Installation

You need Elixir installed to run this one (duh!). [Follow this link](https://elixir-lang.org/install.html) to do so if you haven't already.

- Clone this repository
- `mix run --no-halt`
- Go to `http://localhost:4001/`
- Interact with Graphiql
- Follow the schema docs from the playground

### Query examples

![Playground Screenshot](https://i.imgur.com/MlpgPcY.png)

To list all shows:

```
{
  shows {
    id
    title
    date
  }
}
```

Optionally, you can sort by `TITLE` by putting `shows(sortBy:TITLE)`. You can do the same with `DATE`.

To list all dates for "The 100"

```
{
  shows(title:"The 100") {
    id
    title
    date
  }
}
```

`shows(title:"The 100", episode:"S05E08")` will give you the info of "The 100"-s episode 8 of season 5.

Note that you can put one of `title`, `date`, `id`, `seriesId`, or `sortBy`.

`episode` can only be used with `title` as a co-arg.

### Mutation Examples

You can re-fetch all the dates from [airdates.tv](http://airdates.tv) by running the following mutation:

```
mutation {
  reload {
    id
  }
}
```