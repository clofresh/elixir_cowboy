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

