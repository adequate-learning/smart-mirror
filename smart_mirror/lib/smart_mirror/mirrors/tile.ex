defmodule SmartMirror.Mirrors.Tile do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmartMirror.Mirrors.Tile


  schema "tiles" do
    field :distance, :float
    field :humidity, :integer
    field :name, :string
    field :temperature, :integer

    timestamps()
  end

  @doc false
  def changeset(%Tile{} = tile, attrs) do
    tile
    |> cast(attrs, [:name, :distance, :temperature, :humidity])
    # |> validate_required([:name, :distance, :temperature, :humidity])
  end
end
