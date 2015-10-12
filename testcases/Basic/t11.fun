let a = fn x => fn x2 => x2 x in
let b = fn y => fn y2 => y2 y in
let g = fn z => z 1 in
(g a) (fn u => u + 1) + (g b) (fn w => w - 1)