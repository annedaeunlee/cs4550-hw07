# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsWeb.PageController do
  use EventsWeb, :controller

  #alias Events.Posts

  def index(conn, _params) do
    #posts = Posts.list_posts()
    #render(conn, "index.html", posts: posts)
    render(conn, "index.html")
  end
end
