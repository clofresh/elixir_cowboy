defmodule :elixir_cowboy_sup do
	@behavior :supervisor

	def start_link() do
		Erlang.supervisor.start_link({:local, :elixir_cowboy_sup}, :elixir_cowboy_sup, [])
	end

	def init([]) do
		{:ok, {{:one_for_one, 10, 10}, []}}
	end
end

