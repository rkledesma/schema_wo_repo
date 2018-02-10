defmodule SchemaWoRepoWeb.PetControllerTest do
  use SchemaWoRepoWeb.ConnCase

  alias SchemaWoRepo.Pets

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

  setup :apply_valid_headers

  def fixture(:pet) do
    {:ok, pet} = Pets.create_pet(@valid_attrs)
    pet
  end

  describe "create pet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, pet_path(conn, :create), data: %{attributes: @valid_attrs})
      response = json_response(conn, 202)
      assert response == %{"data" => "accepted"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, pet_path(conn, :create), data: %{attributes: @invalid_attrs})
      response = json_response(conn, 400)
      assert is_standard_error_response?(response)
      assert error_message_contains?(response, "address")
      assert error_message_contains?(response, "license")
      assert error_message_contains?(response, "name")
      assert error_message_contains?(response, "type")
    end
  end

  defp apply_valid_headers(%{conn: conn}) do
    conn =
      conn
      |> Plug.Conn.put_req_header("accept", "application/vnd.api+json")
      |> Plug.Conn.put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
end
