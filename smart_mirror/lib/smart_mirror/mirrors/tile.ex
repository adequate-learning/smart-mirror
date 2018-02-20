defmodule SmartMirror.Mirrors.Tile do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmartMirror.Mirrors.Tile


  schema "tiles" do
    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(%Tile{} = tile, attrs) do
    tile
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
