# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule Events.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do

      add :post_id, references(:posts), null: false
      add :user_id, references(:users), null: false
      add :comment, :string, null: false
      add :response, :string, null: false

      timestamps()
    end

    create unique_index(:invites, [:post_id, :user_id])

  end
end
