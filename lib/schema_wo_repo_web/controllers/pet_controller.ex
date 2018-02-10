defmodule SchemaWoRepoWeb.PetController do
  use SchemaWoRepoWeb, :controller

  alias SchemaWoRepo.Pets
  alias SchemaWoRepoWeb.ChangesetErrorsView

  def create(conn, %{"data" => %{"attributes" => attributes}}) do
    case Pets.create_pet(attributes) do
      {:ok, _pet} ->
        conn
        |> put_status(202)
        |> render("accepted.json", response: "accepted")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(400)
        |> render(ChangesetErrorsView, "error.json", changeset: changeset)
    end
  end
end
