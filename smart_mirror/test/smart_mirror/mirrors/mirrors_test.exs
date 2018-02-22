defmodule SmartMirror.MirrorsTest do
  use SmartMirror.DataCase

  alias SmartMirror.Mirrors

  describe "tiles" do
    alias SmartMirror.Mirrors.Tile

    @valid_attrs %{distance: 120.5, humidity: 42, name: "some name", temperature: 42}
    @update_attrs %{distance: 456.7, humidity: 43, name: "some updated name", temperature: 43}
    @invalid_attrs %{distance: nil, humidity: nil, name: nil, temperature: nil}

    def tile_fixture(attrs \\ %{}) do
      {:ok, tile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mirrors.create_tile()

      tile
    end

    test "list_tiles/0 returns all tiles" do
      tile = tile_fixture()
      assert Mirrors.list_tiles() == [tile]
    end

    test "get_tile!/1 returns the tile with given id" do
      tile = tile_fixture()
      assert Mirrors.get_tile!(tile.id) == tile
    end

    test "create_tile/1 with valid data creates a tile" do
      assert {:ok, %Tile{} = tile} = Mirrors.create_tile(@valid_attrs)
      assert tile.distance == 120.5
      assert tile.humidity == 42
      assert tile.name == "some name"
      assert tile.temperature == 42
    end

    test "create_tile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mirrors.create_tile(@invalid_attrs)
    end

    test "update_tile/2 with valid data updates the tile" do
      tile = tile_fixture()
      assert {:ok, tile} = Mirrors.update_tile(tile, @update_attrs)
      assert %Tile{} = tile
      assert tile.distance == 456.7
      assert tile.humidity == 43
      assert tile.name == "some updated name"
      assert tile.temperature == 43
    end

    test "update_tile/2 with invalid data returns error changeset" do
      tile = tile_fixture()
      assert {:error, %Ecto.Changeset{}} = Mirrors.update_tile(tile, @invalid_attrs)
      assert tile == Mirrors.get_tile!(tile.id)
    end

    test "delete_tile/1 deletes the tile" do
      tile = tile_fixture()
      assert {:ok, %Tile{}} = Mirrors.delete_tile(tile)
      assert_raise Ecto.NoResultsError, fn -> Mirrors.get_tile!(tile.id) end
    end

    test "change_tile/1 returns a tile changeset" do
      tile = tile_fixture()
      assert %Ecto.Changeset{} = Mirrors.change_tile(tile)
    end
  end
end
