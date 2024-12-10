require Ecto.Query
alias Friends.{Movie, Character, Actor, Repo}

movie = %Movie{title: "Ready player one", tagline: "Smothing about video games"}

movie = Repo.insert!(movie)

character = Ecto.build_assoc(movie, :characters, %{name: "Wade Watts"})
Repo.insert(character)

distributor = Ecto.build_assoc(movie, :distributor, %{name: "Netflix"})

Repo.insert(distributor)

actor = %Actor{name: "Tyler Sheridan"}
actor = Repo.insert!(actor)

movie = Repo.preload(movie, [:distributor, :characters, :actors])
movie_changeset = Ecto.Changeset.change(movie)

movie_actors_changeset = movie_changeset |> Ecto.Changeset.put_assoc(:actors, [actor])
Repo.update!(movie_actors_changeset)

changeset = movie_changeset |> Ecto.Changeset.put_assoc(:actors, [%{name: "Gary"}])

Repo.update!(changeset)

Ecto.Query.select("select * from information_schema.tables", [], Repo)
