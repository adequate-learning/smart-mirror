defmodule SmartMirrorWeb.TileController do
  use SmartMirrorWeb, :controller

  alias SmartMirror.Mirrors
  alias SmartMirror.Mirrors.Tile

  action_fallback SmartMirrorWeb.FallbackController

  def index(conn, _params) do
    tiles = Mirrors.list_tiles()
    render(conn, "index.json", tiles: tiles)
  end

  def create(conn, %{"tile" => tile_params}) do
    with {:ok, %Tile{} = tile} <- Mirrors.create_tile(tile_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tile_path(conn, :show, tile))
      |> render("show.json", tile: tile)
    end
  end

  def show(conn, %{"id" => id}) do
    tile = Mirrors.get_tile!(id)
    render(conn, "show.json", tile: tile)
  end

  def update(conn, %{"id" => id, "tile" => tile_params}) do
    tile = Mirrors.get_tile!(id)

    with {:ok, %Tile{} = tile} <- Mirrors.update_tile(tile, tile_params) do
      render(conn, "show.json", tile: tile)
    end
  end

  def delete(conn, %{"id" => id}) do
    tile = Mirrors.get_tile!(id)
    with {:ok, %Tile{}} <- Mirrors.delete_tile(tile) do
      send_resp(conn, :no_content, "")
    end
  end
end
