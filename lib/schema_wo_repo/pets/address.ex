defmodule SchemaWoRepo.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias SchemaWoRepo.Address

  @required_fields ~w(
    address_line_1
    city
    state
    zip
  )a

  @primary_key false
  embedded_schema do
    field(:address_line_1, :string)
    field(:address_line_2, :string)
    field(:city, :string)
    field(:state, :string)
    field(:zip, :string)
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, __schema__(:fields))
    |> validate_required(@required_fields)
    |> validate_length(:address_line_1, max: 100)
    |> validate_length(:address_line_2, max: 100)
    |> validate_length(:city, max: 100)
    |> validate_length(:state, is: 2)
    |> validate_length(:zip, max: 5)
  end
end
