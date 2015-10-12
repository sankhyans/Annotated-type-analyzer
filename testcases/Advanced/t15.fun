let x = fn y => 
	case y of Cons(z,zs) => 
		zs 
	or Nil =>  
		y
in x Cons(1, Cons(2, Nil))
