defmodule SmartMirrorWeb.TileControllerTest do
  use SmartMirrorWeb.ConnCase

  alias SmartMirror.Mirrors

  @create_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  def fixture(:tile) do
    {:ok, tile} = Mirrors.create_tile(@create_attrs)
    tile
  end

  describe "index" do
    test "lists all tiles", %{conn: conn} do
      conn = get conn, tile_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Tiles"
    end
  end

  describe "new tile" do
    test "renders form", %{conn: conn} do
      conn = get conn, tile_path(conn, :new)
      assert html_response(conn, 200) =~ "New Tile"
    end
  end

  describe "create tile" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, tile_path(conn, :create), tile: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == tile_path(conn, :show, id)

      conn = get conn, tile_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Tile"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, tile_path(conn, :create), tile: @invalid_attrs
      assert html_response(conn, 200) =~ "New Tile"
    end
  end

  describe "edit tile" do
    setup [:create_tile]

    test "renders form for editing chosen tile", %{conn: conn, tile: tile} do
      conn = get conn, tile_path(conn, :edit, tile)
      assert html_response(conn, 200) =~ "Edit Tile"
    end
  end

  describe "update tile" do
    setup [:create_tile]

    test "redirects when data is valid", %{conn: conn, tile: tile} do
      conn = put conn, tile_path(conn, :update, tile), tile: @update_attrs
      assert redirected_to(conn) == tile_path(conn, :show, tile)

      conn = get conn, tile_path(conn, :show, tile)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, tile: tile} do
      conn = put conn, tile_path(conn, :update, tile), tile: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Tile"
    end
  end

  describe "delete tile" do
    setup [:create_tile]

    test "deletes chosen tile", %{conn: conn, tile: tile} do
      conn = delete conn, tile_path(conn, :delete, tile)
      assert redirected_to(conn) == tile_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, tile_path(conn, :show, tile)
      end
    end
  end

  defp create_tile(_) do
    tile = fixture(:tile)
    {:ok, tile: tile}
  end
end
