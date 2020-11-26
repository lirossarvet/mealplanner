defmodule Mealplanner.Meals.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :directions, :string
    field :ingredients, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :ingredients, :url, :directions])
    |> validate_required([:title])
  end
end
