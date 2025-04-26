fun to_the_n ( n,x)=
    if n = 0
    then x
    else 2 * to_the_n(n-1,x)

fun nth_tail_lame (n, xs) =
    if n = 0
    then xs
    else tl(nth_tail_lame(n-1, xs))


 fun n_times (f, n , x) =
     if n = 0
     then x
     else f (n_times(f,n-1,x))



 fun triple_n_times (n,x) =
     n_times((fn x => 3*x),n,x)


 fun map (f, xs) =
     case xs of
	 [] => []
       | x::xs' => (f x)::map(f,xs')


 fun filter (f, xs) =
     case xs of
	 [] => []
       | x::xs' => if f x
		   then x::(filter (f, xs'))
		   else filter(f,xs')

 fun fold (f, acc, xs) =
     case xs of
	 [] => acc
      | x::xs =>fold (f, f(acc, x), xs) 



 fun sqrt_of_abs_bad i = Math.sqrt (Real.fromInt (abs i))
 fun sqrt_of_abs i = (Math.sqrt o Real.fromInt o abs) i
						      
 val sorted = fn x => fn y => fn z => z>=y andalso y>=x
 val t1 = ((sorted 7)9)11
 val t2 = sorted 7 9 11

 fun sorted1 x y z = z>=y andalso y>=x
