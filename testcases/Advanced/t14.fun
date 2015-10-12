fn x => if x > 0 then Cons(fn y => y, fn y => y)
else Cons(fn z => z, Nil)