defmodule SmartMirrorWeb.PageController do
  use SmartMirrorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
