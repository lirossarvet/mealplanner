defmodule Mealplanner.Food.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :description, :string
    field :directions, :string
    field :ingredients, :string
    field :source, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :description, :source, :ingredients, :directions])
    |> validate_required([:title, :ingredients, :directions])
  end
end
