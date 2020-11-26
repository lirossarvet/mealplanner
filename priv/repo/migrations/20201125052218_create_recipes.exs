defmodule Mealplanner.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :title, :string
      add :ingredients, :text
      add :url, :text
      add :directions, :text

      timestamps()
    end
  end
end
