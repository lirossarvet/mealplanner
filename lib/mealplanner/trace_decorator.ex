defmodule Mealplanner.TraceDecorator do
  # use Opencensus.Honeycomb.Decorator

  def decorate(event_data, _) do
    Map.put(event_data, "phx_env", Mix.env())
  end
end
