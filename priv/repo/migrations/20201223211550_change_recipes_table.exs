defmodule Mealplanner.Repo.Migrations.ChangeRecipesTable do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      remove :url
      add :source, :text
    end
  end
end
