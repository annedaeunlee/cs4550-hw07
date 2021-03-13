# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule Events.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :comment, :string
    field :response, :string

    belongs_to :user, Events.Users.User
    belongs_to :post, Events.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:comment, :response, :user_id, :post_id])
    |> validate_required([:user_id, :post_id])
  end
end
