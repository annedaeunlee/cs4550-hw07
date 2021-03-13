# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule Events.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, references(:users), null: false
      add :date, :naive_datetime, null: false
      add :name, :string, null: false
      add :description, :string, null: false

      timestamps()
    end

  end
end


