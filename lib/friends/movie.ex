defmodule Friends.Movie do
  use Ecto.Schema

  schema "movies" do
    field(:title, :string)
    field(:tagline, :string)
    has_many(:characters, Friend.Character)
    has_one(:distributor, Friends.Distributor)
  end
end
