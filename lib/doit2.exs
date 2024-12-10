alias Friends.{Repo, Movie}
Repo.get(Movie, 1)

Repo.get_by(Movie, title: "Ready player one")
Repo.get_by(Movie, tagline: "Smothing about video games")

import Ecto.Query

# query
query = from(Movie, where: [title: "Ready player one"], select: [:title, :tagline])
Repo.all(query)

from("movies", where: [title: "Ready player one"], select: [:title, :tagline]) |> Repo.all()

# var in Schema 式: select で指定したデータ構造でデータを取り出せる (list, keyword list, map, struct)
from(m in Movie, where: m.id < 2, select: %{title: m.title}) |> Repo.all()

# select マクロ / where マクロ
# クエリを作成する |> クエリをパイプで変形する |> 実行する
query = select(Movie, [m], m.title) |> where(title: "Ready player one")
Repo.all(query)

query = select(Movie, [m], title: m.title) |> where([m], m.id == 1)
Repo.all(query)

# クエリ構築マクロの最初の関数の第一引数にモジュール、以降は第一引数がクエリstruct
# where と select の順番が変わってもいい
Movie |> where([m], m.id == 1) |> select([m], m.title) |> Repo.all()
from(Movie) |> limit(1) |> select([:title, :id]) |> Repo.all()

# なれると結構直感的

# クエリ内でバインディングされた変数でなく、外部の変数をキャプチャして使う場合は ^ ピン演算子が必要
expected_title = "Ready player one"
Movie |> select([m], m.title) |> where([m], m.title == ^expected_title) |> Repo.all()

# first/last
# %Movie{title: "Devil man", tagline: "Something about demons"} |> Repo.insert!()
Movie |> order_by(desc: :id) |> first |> Repo.all()
Movie |> order_by(asc: :id) |> last |> Repo.one()
