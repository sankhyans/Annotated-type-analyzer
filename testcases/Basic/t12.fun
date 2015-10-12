let abs = fn x => if (x < 0) then -x else x in
let y = abs (-3) in
let z = abs true in
y+z