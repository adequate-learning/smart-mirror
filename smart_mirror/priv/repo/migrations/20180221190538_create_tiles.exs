defmodule SmartMirror.Repo.Migrations.CreateTiles do
  use Ecto.Migration

  def change do
    create table(:tiles) do
      add :name, :string
      add :temperature, :integer
      add :humidity, :integer
      add :distance, :float

      timestamps()
    end

  end
end
