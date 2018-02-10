defmodule SchemaWoRepoWeb.JsonApiTestHelper do
  @moduledoc "Helper functions for JSON API tests"

  @standard_error_keys MapSet.new(~w(id links status code title detail source meta))

  def is_standard_error_response?(response) do
    is_map(response) and Map.has_key?(response, "errors") and is_list(response["errors"]) and
      has_standard_error_substructure?(response)
  end

  defp has_standard_error_substructure?(response) do
    Enum.reduce(response["errors"], true, fn error, acc ->
      acc and MapSet.new(Map.keys(error)) |> MapSet.subset?(@standard_error_keys)
    end)
  end

  def error_message_contains?(response, msg_str) do
    Enum.find(response["errors"], fn error ->
      Map.get(error, "detail", "") =~ ~r/#{msg_str}/i
    end)
  end
end
