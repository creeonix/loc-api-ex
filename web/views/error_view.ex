defmodule LocationsApi.ErrorView do
  use LocationsApi.View

  def render("404.html", _assigns) do
    %{ errors: ["Nothing to do here. See documentation on API calls."] }
  end

  def render("500.html", _assigns) do
    %{ errors: ["Internal server error"] }
  end

  # Render all other templates as 500
  def render(_, assigns) do
    %{ errors: ["Internal server error"] }
  end
end
