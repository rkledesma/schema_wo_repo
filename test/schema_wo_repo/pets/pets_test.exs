defmodule SchemaWoRepo.PetsTest do
  use SchemaWoRepo.DataCase

  alias SchemaWoRepo.Pets

  describe "pets" do
    alias SchemaWoRepo.Pets.Pet

    @valid_attrs %{
      license: 42,
      name: "some name",
      type: "1",
      address: %{
        address_line_1: "123 First St",
        city: "Brookyln",
        state: "NY",
        zip: "11215"
      }
    }
    @invalid_attrs %{license: nil, name: nil, type: nil}

    test "create_pet/1 with valid data creates a pet" do
      assert {:ok, %Pet{} = pet} = Pets.create_pet(@valid_attrs)
      assert pet.license == 42
      assert pet.name == "some name"
      assert pet.type == "cat"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pets.create_pet(@invalid_attrs)
    end
  end
end
