let f =
  fun f a =>
    case a of
      Cons(x, xs) => x 1 + f xs
      or Nil => 0
in
let lst =
  Cons(fn x => x + 1, Cons(fn y => y - 1, Cons(fn z => z, Nil)))
in
f lst