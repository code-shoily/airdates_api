defmodule AirdatesApi.SeriesStore do
  use GenServer

  def add(pid, [id: _, date: _, title: _] = line) do
    GenServer.cast(pid, {:add, line})
  end

  def find_by_title(pid, title) do
    GenServer.call(pid, {:find_by_title, title})
  end

  def find_by_date(pid, date) do
    GenServer.call(pid, {:find_by_date, date})
  end

  @impl true
  def init(_) do
    {:ok, %{by_date: %{}, by_title: %{}}}
  end

  @impl true
  def handle_call({:find_by_title, _title}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:find_by_date, _date}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:add, [id: _, date: date, title: title] = line}, state) do
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
         |> Map.get(title, [])
         |> Kernel.++(line)
     }}
  end
end
