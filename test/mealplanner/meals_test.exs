defmodule Mealplanner.MealsTest do
  use Mealplanner.DataCase

  alias Mealplanner.Meals

  describe "recipes" do
    alias Mealplanner.Meals.Recipe

    @valid_attrs %{
      directions: "some directions",
      ingredients: "some ingredients",
      title: "some title",
      source: "some url"
    }
    @update_attrs %{
      directions: "some updated directions",
      ingredients: "some updated ingredients",
      title: "some updated title",
      source: "some updated url"
    }
    @invalid_attrs %{directions: nil, ingredients: nil, title: nil, url: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meals.create_recipe()

      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Meals.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Meals.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Meals.create_recipe(@valid_attrs)
      assert recipe.directions == "some directions"
      assert recipe.ingredients == "some ingredients"
      assert recipe.title == "some title"
      assert recipe.source == "some url"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meals.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = Meals.update_recipe(recipe, @update_attrs)
      assert recipe.directions == "some updated directions"
      assert recipe.ingredients == "some updated ingredients"
      assert recipe.title == "some updated title"
      assert recipe.source == "some updated url"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Meals.update_recipe(recipe, @invalid_attrs)
      assert recipe == Meals.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Meals.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Meals.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Meals.change_recipe(recipe)
    end
  end
end
