# Some of the code below was taken from Professor Nat Tuck's scratch Repository
defmodule EventsWeb.SessionController do
    use EventsWeb, :controller

    def delete(conn, _params) do
        conn
        |> delete_session(:user_id)
        |> put_flash(:info, "You are logged out.")
        |> redirect(to: Routes.page_path(conn, :index))
      end
  
    def create(conn, %{"name" => name}) do
      user = Events.Users.get_user_by_name(name)
      if user do
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome #{user.name}")
        |> redirect(to: Routes.page_path(conn, :index))
      else
        conn
        |> put_flash(:error, "Invalid Login.")
        |> redirect(to: Routes.page_path(conn, :index))
      end
    end

  end