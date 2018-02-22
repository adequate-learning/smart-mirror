defmodule SmartMirrorWeb.TileView do
  use SmartMirrorWeb, :view
  alias SmartMirrorWeb.TileView

  def render("index.json", %{tiles: tiles}) do
    %{data: render_many(tiles, TileView, "tile.json")}
  end

  def render("show.json", %{tile: tile}) do
    %{data: render_one(tile, TileView, "tile.json")}
  end

  def render("tile.json", %{tile: tile}) do
    %{id: tile.id,
      name: tile.name,
      distance: tile.distance,
      temperature: tile.temperature,
      humidity: tile.humidity}
  end
end
