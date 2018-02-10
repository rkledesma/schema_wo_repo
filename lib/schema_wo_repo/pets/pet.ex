defmodule SchemaWoRepo.Pets.Pet do
  use Ecto.Schema
  import Ecto.Changeset
  alias SchemaWoRepo.Pets.{Pet, PetCode}
  alias SchemaWoRepo.Address

  @required_fields ~w(
    license
    name
    type
  )a

  @primary_key false
  embedded_schema do
    field(:license, :integer)
    field(:name, :string)
    field(:type, PetCode)
    field(:rating, :integer)
    field(:description, :string)
    embeds_one(:address, Address)

    embeds_many :owners, Owner do
      field(:name, :string)
      field(:start, :date)
      field(:end, :date)
    end
  end

  @doc false
  def changeset(%Pet{} = pet, attrs) do
    pet
    |> cast(attrs, __schema__(:fields) -- [:address, :owners])
    |> validate_required(@required_fields, message: "is required")
    |> validate_inclusion(:rating, 1..5, message: "must be between 1 and 5")
    |> validate_inclusion(:type, ~w(cat hamster), message: "can't be a dog")
    |> cast_embed(:address, required: true)
    |> cast_embed(:owners, with: &owner_changeset/2)
    |> validate_divisble_by_3(:license)
  end

  defp validate_divisble_by_3(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, license ->
      case rem(license, 3) == 0 do
        true -> []
        false -> [{field, options[:message] || "must be divisible by 3"}]
      end
    end)
  end

  defp owner_changeset(schema, params) do
    schema
    |> cast(params, [:name, :start, :end])
    |> validate_required([:name])
  end
end
