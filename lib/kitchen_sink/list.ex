defmodule KitchenSink.List do
  @moduledoc """
  this module is for List functions
  """

  alias __MODULE__.IndexBy

  defdelegate index_by(list, path), to: IndexBy

  @doc """
  takes a list of maps, transforms it into a map of maps with their value being the value_key. basically making a
  look-up table.
  """
  def index_on(list_of_maps, take_keys, value_key) do
    take_keys = take_keys |> List.wrap |> MapSet.new |> MapSet.delete(value_key)
    lookup_transform = fn(map) ->
      {
        Map.take(map, take_keys),
        map[value_key]
      }
    end

    list_of_maps
    |> Enum.map(lookup_transform)
    |> Map.new
  end

  @doc """
  A convenient version of what is perhaps the most common use-case for map: extracting a list of property values.

  With a List of Maps, extract 1 value defined by the key you give to pluck.
  """
  def pluck(list_of_maps, key) do
    Enum.map(list_of_maps, &Map.get(&1, key))
  end
end
