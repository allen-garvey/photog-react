defmodule PhotogWeb.PageController do
  use PhotogWeb, :controller

  def index(conn, _params) do
    # render conn, "index.html"
    redirect conn, to: "/index.html"
  end
end
