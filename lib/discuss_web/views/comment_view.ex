defmodule DiscussWeb.CommentView do
  use DiscussWeb, :view

  def render("index.json", %{comments: comments}) do
    comments
    |> Enum.map(&render("show.json", %{comment: &1}))
  end

  def render("show.json", %{comment: comment}) do
    %{
      content: comment.content,
      user_id: comment.user_id,
      topic_id: comment.topic_id,
      inserted_at: comment.inserted_at,
      updated_at: comment.updated_at
    }
  end
end
