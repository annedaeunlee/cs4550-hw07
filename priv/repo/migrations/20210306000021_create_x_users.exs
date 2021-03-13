# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule Events.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :photo_hash, :text, null: false

      timestamps()
    end

    create index(:users, [:email], unique: true)

  end
end
