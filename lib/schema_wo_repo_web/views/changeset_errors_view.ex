defmodule SchemaWoRepoWeb.ChangesetErrorsView do
  use SchemaWoRepoWeb, :view

  @doc """
  Transforms an error Changeset into JSON-API standard respose
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    errors =
      changeset
      |> translate_errors()
      |> traverse_errors()

    %{errors: errors}
  end

  defp traverse_errors(msgs) do
    Enum.flat_map(msgs, fn {field, msg} ->
      cond do
        is_list(msg) ->
          serialize_error(field, msg)

        is_map(msg) ->
          traverse_errors(msg)

        true ->
          %{}
      end
    end)
  end

  defp serialize_error(field, msgs) do
    for msg <- msgs do
      %{
        detail: "#{field}: #{msg}",
        source: %{parameter: field}
      }
    end
  end
end
