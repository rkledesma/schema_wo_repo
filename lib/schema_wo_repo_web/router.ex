defmodule SchemaWoRepoWeb.Router do
  use SchemaWoRepoWeb, :router

  pipeline :api do
    plug(:accepts, ~w(json-api))
    plug(JSONAPI.PlugResponseContentType)
    plug(JSONAPI.EnsureSpec)
  end

  scope "/", SchemaWoRepoWeb do
    pipe_through(:api)
    post("/pets", PetController, :create)
  end
end
