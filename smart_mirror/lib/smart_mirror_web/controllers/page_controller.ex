defmodule SmartMirrorWeb.PageController do
  use SmartMirrorWeb, :controller

  alias SmartMirror.Mirrors
  alias SmartMirror.Mirrors.Tile

  def index(conn, _params) do
    tile = Mirrors.most_recent_entry() 
    render(conn, "index.html", tile: tile)
  end
end
