
fun countup (x : int) =
    let
	fun count (from: int) =
	    if from = x
	    then x::[]
	    else from :: count(from + 1)
    in
	count(x)
    end
