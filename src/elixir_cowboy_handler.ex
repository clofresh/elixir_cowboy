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
