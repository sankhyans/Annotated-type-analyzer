let append = fun app xs => fn ys =>
             case xs of Cons(z,sz) => Cons(z, app sz ys)
                     or Nil        => ys
in
let reverse = fun rev vs =>
              case vs of Cons(u,us) => append (rev us) Cons(u,Nil)
                      or Nil        => Nil
in
reverse Cons(1,Cons(2,Nil))