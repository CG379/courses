fun match xs =
    let fun one xs =
	    case xs of
		[] => true
	      | 1::xs' => two xs'
	      | _ => false
	and two xs =
	    case xs of
		[] => false
	      | 2::xs' => one xs'
	      | _  => false
    in
	one xs
    end
	
datatype t1 = Foo of int | Bar of t2
     and t2 = Baz of string |Quux of t1

fun no_0_or_empty_t1 x=
    case x of
	Foo i => i <> 0
      | Bar y =>  no_0_or_empty_t2 y
and no_0_or_empty_t2 x =
    case x of
	Baz s => size s > 0
      | Quux y => no_0_or_empty_t1 y





signature MATHLIB =
sig
    val fact : int -> int
    val half_pi : real
end


structure MyMathLib :> MATHLIB =
struct
fun fact x =
    let fun fact_tail (x, n) =
	if x = 0
	then n
	else fact_tail (x-1, x*n)
    in
	fact_tail (x,1)
    end

val half_pi = Math.pi / 2.0
fun double y = 2*y
end
    
	
				   
