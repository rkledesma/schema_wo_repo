defmodule SchemaWoRepoWeb.PetView do
  use SchemaWoRepoWeb, :view

  @spec render(String.t(), Map) :: Map
  def render("accepted.json", %{response: response}), do: %{data: response}
end
