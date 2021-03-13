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

  def create(conn, %{"invite" => invite_params}) do
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

    Invites.update_invite(invite, %{post_id: invite.post_id, user_id: invite.user_id, response: invite.response, comment: ""})
    {:ok, _invite} = Invites.update_invite(invite, %{post_id: invite.post_id, user_id: invite.user_id, response: invite.response, comment: "   "})

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :show, invite.post_id))
  end
end
