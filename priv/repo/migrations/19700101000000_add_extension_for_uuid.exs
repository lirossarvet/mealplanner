defmodule Mealplanner.Repo.Migrations.AddExtensionForUuid do
  use Ecto.Migration

  def change do
    execute(~s(CREATE EXTENSION IF NOT EXISTS "uuid-ossp"), ~s(DROP EXTENSION IF EXISTS "uuid-ossp"))
  end
end
