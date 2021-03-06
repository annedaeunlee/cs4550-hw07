# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsWeb.PostController do
  use EventsWeb, :controller

  alias Events.Posts
  alias Events.Posts.Post
  alias EventsWeb.Plugs

  plug Plugs.RequireUser when action in [:new, :edit, :create, :update]
  plug :fetch_post when action in [:show, :edit, :update, :delete]
  plug :require_owner when action in [:edit, :update, :delete]
  


  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    post = conn.assigns[:post]

    if user.id == post.user_id do
      conn
    else
      conn
      |> put_flash(:error, "That isn't yours.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end


  def fetch_post(conn, _args) do
    id = conn.params["id"]
    post = Posts.get_post!(id)
    assign(conn, :post, post)
  end



  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    post_params = post_params
    |> Map.put("user_id", conn.assigns[:current_user].id)

    case Events.Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    #post = Posts.get_post!(id)
    post = conn.assigns[:post]
    invites = Events.Posts.get_invites(post.id)
    render(conn, "show.html", post: post, invites: invites)
  end

  def show_invites(conn, %{"id" => id}) do
    invites = Events.Posts.get_invites(id)
    render(conn, "show_invites.html", invites: invites)
  end

  def edit(conn, %{"id" => id}) do
    #post = Posts.get_post!(id)
    post = conn.assigns[:post]
    changeset = Events.Posts.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    #post = Posts.get_post!(id)
    post = conn.assigns[:post]

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    #post = Posts.get_post!(id)
    post = conn.assigns[:post]
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
