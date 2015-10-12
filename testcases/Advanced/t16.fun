let g = fun map xs =>
case xs of Cons(f,xs1) => Cons(f, map xs1)
or Nil => Nil
in let lst = Cons(fn x => x+3, Cons(fn y => y, Nil))
in case (g lst ) of Cons (h, hs) => h 4
or Nil => 0