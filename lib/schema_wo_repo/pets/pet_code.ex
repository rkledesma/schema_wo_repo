defmodule SchemaWoRepo.Pets.PetCode do
  @moduledoc "Custom type: pet type expressed as code or string"
  @behaviour Ecto.Type
  def type, do: :string

  @coded_types %{
    1 => "cat",
    2 => "dog"
  }

  def cast(arg) when is_integer(arg), do: Map.fetch(@coded_types, arg)
  def cast({int, _}), do: cast(int)
  def cast(arg) when is_binary(arg), do: cast(Integer.parse(arg))
  def cast(_), do: :error

  def load(pet_type) when is_binary(pet_type), do: {:ok, pet_type}
  def dump(_), do: :error
end
