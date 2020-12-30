defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn

  alias Discuss.{Repo, User}

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    user_or_nil = user_id && Repo.get(User, user_id)
    assign(conn, :user, user_or_nil)
  end
end
