defmodule MealplannerWeb.RecipeController do
  use MealplannerWeb, :controller

  alias Mealplanner.Food
  alias Mealplanner.Food.Recipe

  def index(conn, _params) do
    recipes = Food.list_recipes()
    render(conn, "index.html", recipes: recipes)
  end

  def new(conn, _params) do
    changeset = Food.change_recipe(%Recipe{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    case Food.create_recipe(recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, gettext("%{type} created successfully", type: "Recipe"))
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Food.get_recipe!(id)
    render(conn, "show.html", recipe: recipe)
  end

  def edit(conn, %{"id" => id}) do
    recipe = Food.get_recipe!(id)
    changeset = Food.change_recipe(recipe)
    render(conn, "edit.html", recipe: recipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Food.get_recipe!(id)

    case Food.update_recipe(recipe, recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, gettext("%{type} updated successfully", type: "Recipe"))
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", recipe: recipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Food.get_recipe!(id)
    {:ok, _recipe} = Food.delete_recipe(recipe)

    conn
    |> put_flash(:info, gettext("%{type} deleted successfully", type: "Recipe"))
    |> redirect(to: Routes.recipe_path(conn, :index))
  end
end
