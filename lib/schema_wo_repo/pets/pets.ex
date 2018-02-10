defmodule SchemaWoRepo.Pets do
  @moduledoc """
  The Pets context.
  """

  alias SchemaWoRepo.Pets.Pet
  alias Ecto.Changeset

  @doc """
  Creates a pet.

  ## Examples

      iex> create_pet(%{field: value})
      {:ok, %Pet{}}

      iex> create_pet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet(attrs \\ %{}) do
    pet = Pet.changeset(%Pet{}, attrs)

    if pet.valid? do
      {:ok, Changeset.apply_changes(pet)}
    else
      {:error, pet}
    end
  end
end
