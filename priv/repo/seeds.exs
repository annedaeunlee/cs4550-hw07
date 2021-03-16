# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Events.Repo.insert!(%Events.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

#alias Events.Repo
#alias Events.Users.User
#alias Events.Posts.Post
#alias Events.Photos
#alias Events.Invites.Invite

#defmodule Inject do
#  def photo(name) do
#    photos = Application.app_dir(:events_hw, "priv/photos")
#    path = Path.join(photos, name)
#    {:ok, hash} = Photos.save_photo(name, path)
#    hash
#  end
#end

#binky = Inject.photo("binky.jfif")
#clare = Inject.photo("clare.jfif")

#alice = Repo.insert!(%User{name: "alice", email: "alice@email.com", photo_hash: clare})
#bob = Repo.insert!(%User{name: "bob", email: "bob@email.com", photo_hash: binky})

#alice_meeting = Repo.insert!(%Event{user_id: alice.id, name: "Alice Meeting", description: "Alice says Hi!", date_time: ~N[2022-01-01 23:00:07]})
#Repo.insert!(%Event{user_id: bob.id, name: "Bob Birthday", description: "Bob says garblarg!", date_time: ~N[2021-05-01 23:00:07]})

#Repo.insert!(%Invite{event_id: alice_meeting.id, user_id: bob.id, comment: "Sounds fun!", response: "I'll be there"})