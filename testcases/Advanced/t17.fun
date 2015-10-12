let lst = Cons(fn x => x + 3, Cons(fn y => y, Nil)) in
case lst of
  Cons(x, xs) =>
    case xs of
      Cons(y, ys) => y 1
      or Nil => 2
  or Nil => 3