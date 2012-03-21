defmodule :elixir_cowboy do
	@behavior :application

	def start() do
		Erlang.application.start(:cowboy)
		Erlang.application.start(:elixir_cowboy)		
	end

	def start(_type, _args) do
		dispatch = [
			{:'_', [{:'_', :elixir_cowboy_handler, []}]}
		] 
		Erlang.cowboy.start_listener(:my_http_listener, 100,
			:cowboy_tcp_transport, [{:port, 8080}],
			:cowboy_http_protocol, [{:dispatch, dispatch}]
		)
	end

	def stop(_state) do
		:ok
	end
end

defmodule :elixir_cowboy_handler do
	@behavior :cowboy_http_handler

	def init({_, :http}, req, []) do
		{:ok, req, :undefined}
	end

	def handle(req, state) do
		{:ok, req2} = Erlang.cowboy_http_req.reply(200, [], "Hello world!", req)
		{:ok, req2, state}
	end

	def terminate(_, _) do
		:ok
	end
	
end

defmodule :elixir_cowboy_sup do
	@behavior :supervisor

	def start_link() do
		Erlang.supervisor.start_link({:local, :elixir_cowboy_sup}, :elixir_cowboy_sup, [])
	end

	def init([]) do
		{:ok, {{:one_for_one, 10, 10}, []}}
	end
end

