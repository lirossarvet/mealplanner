defmodule Mealplanner.TracePlug do
  use Opencensus.Plug.Trace, attributes: %{"app.resource_id" => :add_resource_id}

  # This does not playy well with nested resources.
  # It also means Ids get the pluralized version of the name because
  # that's Good Enough for today.
  def span_name(%Plug.Conn{method: method, request_path: request_path}, _) do
    [_ | items] = request_path |> String.split("/")
    resource = List.first(items)

    case length(items) do
      1 ->
        "#{method} /#{resource}"

      2 ->
        "#{method} /#{resource}/:#{resource}_id"

      # Unknown or got to a nested resource
      _ ->
        request_path
    end

    "#{method} #{resource}/:#{resource}_id"
  end

  def add_resource_id(%Plug.Conn{request_path: request_path}) do
    [_ | items] = request_path |> String.split("/")

    case length(items) do
      2 ->
        List.last(items)

      _ ->
        nil
    end
  end
end
