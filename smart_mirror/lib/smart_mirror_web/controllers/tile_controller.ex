defmodule SmartMirrorWeb.TileController do
  use SmartMirrorWeb, :controller

  alias SmartMirror.Mirrors
  alias SmartMirror.Mirrors.Tile

  def index(conn, _params) do
    tiles = Mirrors.list_tiles()
    render(conn, "index.html", tiles: tiles)
  end

  def new(conn, _params) do
    changeset = Mirrors.change_tile(%Tile{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tile" => tile_params}) do
    case Mirrors.create_tile(tile_params) do
      {:ok, tile} ->
        conn
        #|> put_flash(:info, "Tile created successfully.")
        |> redirect(to: tile_path(conn, :show, tile))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tile = Mirrors.get_tile!(id)
    #render(conn, "show.json", tile: tile)
    render(conn, "show.html", tile: tile)
  end

  def edit(conn, %{"id" => id}) do
    tile = Mirrors.get_tile!(id)
    changeset = Mirrors.change_tile(tile)
    render(conn, "edit.html", tile: tile, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tile" => tile_params}) do
    tile = Mirrors.get_tile!(id)

    case Mirrors.update_tile(tile, tile_params) do
      {:ok, tile} ->
        conn
        |> put_flash(:info, "Tile updated successfully.")
        |> redirect(to: tile_path(conn, :show, tile))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tile: tile, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tile = Mirrors.get_tile!(id)
    {:ok, _tile} = Mirrors.delete_tile(tile)

    conn
    |> put_flash(:info, "Tile deleted successfully.")
    |> redirect(to: tile_path(conn, :index))
  end
end
