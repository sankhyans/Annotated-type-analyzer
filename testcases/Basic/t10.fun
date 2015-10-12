let f = fn x => x + 1 in
let g = fn x => x - 1 in
let h = fn x => x * 2 in
let x = fn a => fn b => a b in
let y = fn a => fn b => a b in
(x f) 1 + (x g) 1 + (y g) 2 + (y h) 2