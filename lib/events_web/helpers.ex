# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsWeb.Helpers do

    def have_current_user?(conn) do
      conn.assigns[:current_user] != nil
    end
  
    def current_user_id?(conn, user_id) do
      user = conn.assigns[:current_user]
      user && user.id == user_id
    end

    def current_user_id(conn) do
        user = conn.assigns[:current_user]
        user && user.id
    end
  
    def invited?(conn, post_id, user_id) do
      if current_user_id?(conn, user_id) do
        true
      else
        if have_current_user?(conn) do
          user = conn.assigns[:current_user]
          Events.Invites.is_invited(post_id, user.id)
        else
          false
        end
      end
    end
  end