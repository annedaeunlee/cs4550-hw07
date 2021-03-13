# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule Events.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :date, :naive_datetime
    field :description, :string
    field :name, :string

    belongs_to :user, Events.Users.User
    has_many :invites, Events.Invites.Invite

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:date, :name, :description, :user_id])
    |> validate_required([:date, :name, :description, :user_id])
  end
end
