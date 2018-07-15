defmodule AirdatesApi.SeriesStore do
  use GenServer

  # --------------------------------------------------
  # PUBLIC API
  # --------------------------------------------------
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def reload(pid) do
    GenServer.call(pid, :reload)
  end

  def empty?(pid) do
    GenServer.call(pid, :empty?)
  end

  def list(pid, opts \\ []) do
    GenServer.call(
      pid,
      {:list,
       case opts do
         [sort: attr] when attr in [:title, :date] -> attr
         _ -> :date
       end}
    )
  end

  def find_by_id(pid, id) do
    GenServer.call(pid, {:find, :id, id})
  end

  def find_by_series_id(pid, series_id) do
    GenServer.call(pid, {:find, :series_id, series_id})
  end

  def find_by_title(pid, title) do
    GenServer.call(pid, {:find, :title, title})
  end

  def find_by_title(pid, title, episode) do
    case episode do
      nil -> GenServer.call(pid, {:find, :title, title})
      _ -> GenServer.call(pid, {:find, :title_and_episode, title, episode})
    end
  end

  def find_by_date(pid, date) do
    GenServer.call(pid, {:find, :date, date})
  end

  # --------------------------------------------------
  # GENSERVER CALLBACKS
  # --------------------------------------------------
  @impl true
  def init(_) do
    {:ok, AirdatesApi.Parser.parse()}
  end

  @impl true
  def handle_call({:find, :series_id, series_id}, _from, state) do
    {:reply,
     state
     |> Enum.filter(fn %{series_id: series_id_} ->
       series_id_ == series_id
     end), state}
  end

  @impl true
  def handle_call({:find, :id, id}, _from, state) do
    {:reply,
     state
     |> Enum.filter(fn %{id: id_} ->
       id_ == id
     end), state}
  end

  @impl true
  def handle_call({:find, :title, title}, _from, state) do
    {:reply,
     state
     |> Enum.filter(fn %{title: title_} ->
       title_
       |> String.downcase()
       |> String.starts_with?(
         title
         |> String.downcase()
       )
     end)
     |> Enum.sort_by(& &1[:title]), state}
  end

  @impl true
  def handle_call({:find, :title_and_episode, title, episode}, _from, state) do
    {:reply,
     state
     |> Enum.filter(fn %{title: title_} ->
       title_
       |> String.downcase()
       |> String.starts_with?(
         title
         |> String.downcase()
       )
     end)
     |> Enum.filter(fn %{title: title_} ->
       title_
       |> String.downcase()
       |> String.ends_with?(
         episode
         |> String.downcase()
       )
     end)
     |> Enum.sort_by(& &1[:title]), state}
  end

  @impl true
  def handle_call({:find, :date, date}, _from, state) do
    {:reply,
     state
     |> Enum.filter(fn %{date: date_} -> date_ == date end)
     |> Enum.sort_by(& &1[:date]), state}
  end

  @impl true
  def handle_call({:list, attr}, _from, state) do
    {:reply, state |> Enum.sort_by(& &1[attr]), state}
  end

  @impl true
  def handle_call(:empty?, _from, state) do
    {:reply,
     case state do
       [] -> true
       _ -> false
     end, state}
  end

  @impl true
  def handle_call(:reload, _from, _state) do
    state = AirdatesApi.Parser.parse()
    {:reply, state, state}
  end
end
