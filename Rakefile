task :default => [:build]

directory "ebin"

task :build => ["ebin", :dependencies] do
	sh "elixirc -o ebin/ -pa deps/cowboy/ebin/ src/*.ex"
end

task :dependencies do
	sh "rebar get-deps"
	sh "rebar compile"
end

task :start do
	sh "elixir --erl 'erl -pa ebin/ -pa deps/*/ebin/ -s elixir_cowboy' --no-halt"
end

