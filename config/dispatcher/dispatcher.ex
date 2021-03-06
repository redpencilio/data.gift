defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  get "/images/*path" do
    Proxy.forward conn, path, "http://static-file/images/"
  end

  get "/vocabularies/:name/:version/*path" do
    Proxy.forward conn, [], "http://static-file/vocabularies/" <> name <> "/" <> version <> "/index.ttl"
  end

  get "/vocabularies/:name/*path" do
    Proxy.forward conn, [], "http://static-file/vocabularies/" <> name <> "/index.ttl"
  end

  get "/application-profiles/:name/:version/*path" do
    Proxy.forward conn, path, "http://static-file/application-profiles/" <> name <> "/" <> version <> "/"
  end

  get "/application-profiles/:name" do
    Proxy.forward conn, [], "http://static-file/application-profiles/" <> name <> "/index.html"
  end

  get "/contexts/*path" do
    Proxy.forward conn, path, "http://static-file/contexts/"
  end

  get "/concepts/*path" do
    Proxy.forward conn, path, "http://cache/concepts/"
  end
  get "/concept-schemes/*path" do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
