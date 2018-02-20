defmodule SmartMirror.Repo.Migrations.CreateTiles do
  use Ecto.Migration

  def change do
    create table(:tiles) do
      add :body, :string

      timestamps()
    end

  end
end
