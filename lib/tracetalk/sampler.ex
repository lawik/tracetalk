defmodule Tracetalk.Sampler do
    use GenServer
    def start_link(opts) do
        GenServer.start_link(__MODULE__, opts, opts)
    end

    def init(_opts) do
        {:ok, %{foo: true}, {:continue, :a}}
    end

    def handle_continue(:a, state) do
        _ = :queue.new()
        :timer.sleep(2500)
        {:noreply, state, {:continue, :b}}
    end

    def handle_continue(:b, state) do
        _ = :maps.get(:foo, state)
        :timer.sleep(2500)
        {:noreply, state, {:continue, :a}}
    end
end