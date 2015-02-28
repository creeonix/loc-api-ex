defmodule LocationsApi.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/v1/", LocationsApi do
    pipe_through :api

    get   "/locations/:uid", LocationsController, :index
    post  "/locations", LocationsController, :create
  end

end
