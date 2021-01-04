defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  alias Discuss.{Repo, Topic, Comment}
  alias DiscussWeb.CommentView

  def join("comments:" <> topic_id, _payload, socket) do
    topic_id = String.to_integer(topic_id)

    topic =
      Topic
      |> Repo.get!(topic_id)
      |> Repo.preload(:comments)

    comments = CommentView.render("index.json", %{comments: topic.comments})

    {:ok, %{comments: comments}, assign(socket, :topic, topic)}
  end

  def handle_in("comments:new", %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset =
      topic
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{
          comment: CommentView.render("show.json", %{comment: comment})
        })

        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end

    {:reply, :ok, socket}
  end
end
