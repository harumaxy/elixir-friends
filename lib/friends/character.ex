defmodule Friends.Character do
  use Ecto.Schema

  schema "characters" do
    field(:name, :string)
    belongs_to(:movie, Friend.Movie)
  end
end
