# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsWeb.InviteController do
  use EventsWeb, :controller

  alias Events.Invites
  alias Events.Invites.Invite
  alias Events.Photos

  def index(conn, _params) do
    invites = Invites.list_invites()
    render(conn, "index.html", invites: invites)
  end

  def index_by_post(conn, %{"id" => post_id}) do
    invites = Invites.list_post_invites(post_id)
    render(conn, "index.html", invites: invites)
  end

  def new(conn, _params) do
    changeset = Invites.change_invite(%Invite{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"email" => email, "post" => post_id}) do

    IO.puts email
    user = if Events.Users.get_user_by_email(email) == nil do
      photos = Application.app_dir(:events, "priv/photos")
      path = Path.join(photos, "unknown.jfif.jpeg")
      {:ok, hash} = Photos.save_photo("unkown.jfif.jpeg", path)
      user_params = %{name: "not_registered", email: email, photo_hash: hash}
      {:ok, user} = Events.Users.create_user(user_params)
      IO.puts "USER CREATED"
      IO.puts user.id
      user
    else
      IO.puts "USER EXISTS"
      Events.Users.get_user_by_email(email)
    end
    IO.puts user.id
    invite_params = %{user_id: user.id, post_id: post_id, comment: "comment", response: "no response"}

    case Invites.create_invite(invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite created successfully.")
        |> redirect(to: Routes.invite_path(conn, :show, invite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    render(conn, "show.html", invite: invite)
  end

  def edit(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    changeset = Invites.change_invite(invite)
    render(conn, "edit.html", invite: invite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invite" => invite_params}) do
    invite = Invites.get_invite!(id)

    case Invites.update_invite(invite, invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite updated successfully.")
        |> redirect(to: Routes.invite_path(conn, :show, invite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", invite: invite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)

    Invites.update_invite(invite, %{post_id: invite.post_id, user_id: invite.user_id, response: invite.response, comment: "   "})
    {:ok, _invite} = Invites.update_invite(invite, %{post_id: invite.post_id, user_id: invite.user_id, response: invite.response, comment: "   "})

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :show, invite.post_id))
  end

  #def delete_invitee(conn, %{"id" => id}) do
   # invite = Invites.get_invite!(id)
    #{:ok, _user} = Events.Users.delete_user(invite.user_id)
  
    #conn
    #|> put_flash(:info, "User deleted successfully.")
    #|> redirect(to: Routes.user_path(conn, :index))
  #end
    
end
