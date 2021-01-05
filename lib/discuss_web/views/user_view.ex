defmodule DiscussWeb.UserView do
  use DiscussWeb, :view

  def render("show.json", %{user: user}) do
    %{
      email: user.email
    }
  end
end
