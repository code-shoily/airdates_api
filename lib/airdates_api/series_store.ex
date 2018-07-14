defmodule AirdatesApi.SeriesStore do
  use GenServer

  @type show_line :: [id: binary(), date: binary(), title: binary(), slug: binary()]

  def add(pid, [id: _, date: _, title: _, slug: _] = line) do
    GenServer.cast(pid, {:add, line})
  end

  def empty?(pid) do
    GenServer.call(pid, :empty?)
  end

  def show_all(pid) do
    GenServer.call(pid, :show_all)
  end

  def find_by_title(pid, title) do
    GenServer.call(pid, {:find_by_title, title})
  end

  def find_by_date(pid, date) do
    GenServer.call(pid, {:find_by_date, date})
  end

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  @impl true
  def init(_) do
    {:ok, %{by_date: %{}, by_title: %{}}}
  end

  @impl true
  def handle_call({:find_by_title, _title}, _from, state) do
    # TODO NOT_IMPLEMENTED
    {:reply, state, state}
  end

  @impl true
  def handle_call({:find_by_date, _date}, _from, state) do
    # TODO NOT_IMPLEMENTED
    {:reply, state, state}
  end

  @impl true
  def handle_call(:show_all, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call(:empty?, _from, state) do
    case state do
      %{by_date: %{}, by_title: %{}} -> true
      _ -> false
    end
  end

  @impl true
  def handle_cast({:add, [id: _, date: date, title: _, slug: slug] = line}, state) do
    {:noreply,
     %{
       by_date:
         state
         |> Map.get(:by_date)
         |> Map.get(date, [])
         |> Kernel.++(line),
       by_title:
         state
         |> Map.get(:by_title)
         |> Map.get(slug, [])
         |> Kernel.++(line)
     }}
  end
end
