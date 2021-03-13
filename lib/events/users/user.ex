# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule Events.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :photo_hash, :string

    has_many :posts, Events.Posts.Post
    has_many :invites, Events.Invites.Invite

    timestamps()
  end

  
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :photo_hash])
    |> validate_required([:name, :email, :photo_hash])
    |> unique_constraint(:email)
  end
end
