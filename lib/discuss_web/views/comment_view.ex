defmodule DiscussWeb.CommentView do
  use DiscussWeb, :view

  alias DiscussWeb.{CommentView, UserView}

  def render("index.json", %{comments: comments}) do
    %{comments: render_many(comments, CommentView, "show.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{
      content: comment.content,
      user_id: comment.user_id,
      topic_id: comment.topic_id,
      inserted_at: comment.inserted_at,
      updated_at: comment.updated_at,
      user: comment.user && UserView.render("show.json", %{user: comment.user})
    }
  end
end
