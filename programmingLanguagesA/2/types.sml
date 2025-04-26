datatype testType = TwoInts of int * int
		  | Str of string
		  | Pizza


fun f (x: testType) =
    case x of
	Pizza => 3
      | Str s  => String.size s
      | TwoInts(i1,i2) => i1 + i2
				   

val a = Str "hi"
val b = Str
val c = Pizza
val d = TwoInts(1+2,3+4)
val e = a

     
 (* usefull data types*)
datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp * exp
	     | Multiply of exp * exp

fun eval e =
    case e of
	Constant i => i
      | Negate e2 => ~ (eval e2)
      | Add (e1, e2) => (eval e1) + (eval e2)
      | Multiply (e1, e2) => (eval e1) * (eval e2)

fun max_constant e =
    case e of 
	Constant i => i
      | Negate e2 => max_constant e2
      | Add (e1, e2) => Int.max( max_constant e1 ,max_constant e2)
      | Multiply (e1, e2) => Int.max( max_constant e1 ,max_constant e2)


