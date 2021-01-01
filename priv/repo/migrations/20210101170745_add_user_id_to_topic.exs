defmodule Discuss.Repo.Migrations.AddUserIdToTopic do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :user_id, references(:users)
    end
  end
end
