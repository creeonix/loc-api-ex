defmodule LocationsApi.LocationsController do
  use Phoenix.Controller

  plug :action

  def index(conn, %{ "uid" => uid }) do
    uid = String.replace(uid, ~r/\.json$/, "")
    location = LocationsApi.Location.find(uid)
    json conn, %{ location: location }
  end

  def create(conn, _params) do
    {status, result}  = LocationsApi.Location.create(_params)
    if status == :ok do
      json put_status(conn, 201), %{ location: Map.from_struct(result) }
    else
      json put_status(conn, 422), %{ errors: result }
    end
  end

end
