fun test (n : int) =
    let
	val x = if n < 2 then 24 else n
	val y = x * n				
    in
	if y > x then y * y else x * x
    end

fun test2 () =
    let
	val x = 1
    in
	(let val x = 3 in x + 1 end) + (let val y  = 2 in x + y end)
    end
