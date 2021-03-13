# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsWeb.Plugs.FetchSession do
    import Plug.Conn
  
    def init(args), do: args
  
    def call(conn, _args) do
      user = Events.Users.get_user(get_session(conn, :user_id) || -1)
      if user do
        assign(conn, :current_user, user)
      else
        assign(conn, :current_user, nil)
      end
    end
end