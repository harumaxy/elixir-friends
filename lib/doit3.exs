# preload
# Ecto Schema のリレーションを取得するクエリには、関連スキーマをプリロードしておく必要がある

alias Friends.Character
alias Friends.{Repo, Movie}
import Ecto.Query

# preload: に指定された relation に関しては、その数だけ追加でクエリが発行される
# おそらく、Ecto のコードで join された返される
Repo.all(from(m in Movie, preload: [:actors, :characters, :distributor]))

# join: を指定すると、 SQL JOIN で 1つのトランザクションで取得されるため、若干パフォーマンスがいいかも？
# a in ... でバインディングした変数も、where の条件に使うことができる
from(m in Movie, join: a in assoc(m, :actors), preload: [actors: a]) |> Repo.all()

from(m in Movie,
  join: a in assoc(m, :actors),
  where: a.name == "Tyler Sheridan",
  preload: [actors: a]
)
|> Repo.all()

# iex 技、 式を評価したあと、次の行で |> func でつなげると前の結果をパイプできる

# フェッチ済みレコードへのプリロード
# 既に取得したレコードにリレーションをロードする(preload というより after load)
# INNER JOIN で、元の movie も取得され直してる
movie = Repo.get(Movie, 1)
Repo.preload(movie, :actors)

# Ecto.query.join/5

query = from(m in Movie, where: [stars: 5])

from(c in Character,
  join: ^query,
  on: [id: c.movie_id],
  select: {m.title, c.name},
  where: c.name == "Wade Watts"
)

# from の join: パラメータも使えるし、Ecto.Query.join/5 関数へのパイプスタイルでも書ける
# Join するクエリのバインディング変数も where で使えるし、 subquery を指定して lateral join も可能 (柔軟な構造)

Character |> join()
