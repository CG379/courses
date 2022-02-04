(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)


(*
string list -> string list
returns original list with only strings that start with an uppercase
*)
fun only_capitals (xs) =
    List.filter (fn x => Char.isUpper(String.sub(x,0))) xs


(*
string list -> string
returns longest string in list, no recursion
if tie return closest to front
*)
fun longest_string1 xs =
    foldl (fn (x,y) => if String.size(y) >= String.size(x) then y else x) "" xs


(*
string list -> string
returns longest string in list, no recursion
if tie return closest to back
*)
fun longest_string2 xs =
    foldl (fn (x,y) => if String.size(x) >= String.size(y) then x else y) "" xs



(*
(int * int -> bool) -> string list -> string
passed a function that returns true if the first argument is longer than the second one
*)	  
fun longest_string_helper f = foldl (fn (x,y) => if f(String.size(x), String.size(y)) then x else y) ""

val longest_string3 = longest_string_helper (fn (x,y) => x > y)

val longest_string4 = longest_string_helper (fn (x,y) => x >= y)
					    

(*
string list -> string
returns longest sting that is capitalised
*)
val longest_capitalized  = longest_string3 o only_capitals

(*
string -> string
reverses the string input
*)
val rev_string = String.implode o rev o String.explode


(*
(’a -> ’b option) -> ’a list -> ’b
takes a function and a list returns and option
*)
fun first_answer f lst =
  case lst of
       [] => raise NoAnswer
      | x::t => case f x of
                NONE => first_answer f t
              | SOME y => y
    
	
(*
(’a -> ’b list option) -> ’a list -> ’b list option
*)
fun all_answers f [] = SOME []
  | all_answers f xs =
    let fun apply (n, []) = SOME n
	  | apply (n, SOME(x)::xs) = apply(n @ x, xs)
	  | apply (n, NONE::xs) = NONE
    in
	apply([], map f xs)
    end



fun count_wildcards (p) =
    g (fn () => 1) (fn x => 0) p

fun count_wild_and_variable_lengths (p) =
    g (fn () => 1) (fn x => String.size x) p

fun count_some_var (s,p) =
    g (fn () => 0) (fn x => if x = s then 1 else 0) p



fun  check_pat p =
     let
	 fun get_elements (Variable x) = [x]
	   | get_elements (TupleP ps) = List.foldl (fn (p',n) => n @ get_elements(p')) [] ps
	 | get_elements (_) = []
	 fun repeats ([]) = false
	   | repeats (x::xs) = List.exists (fn x' => x = x') xs orelse repeats xs
	 in
	     (not o repeats o get_elements) p
	 end


fun match(v, p) = 
    case (p, v) of
	(Wildcard, _) => SOME []
      | (Variable s, _) => SOME [(s,v)]
      | (UnitP, Unit) => SOME []
      | (ConstP cp, Const cv) => if cp = cv then SOME [] else NONE
      | (TupleP ps, Tuple vs) => if List.length ps = List.length vs 
				 then all_answers (fn (vs',ps') => match(vs',ps')) (ListPair.zip(vs,ps))
				 else NONE
      | (ConstructorP(s1,pp), Constructor(s2,pv)) => if s1 = s2 then match(pv,pp) else NONE
      | _ => NONE



fun first_match v p =
  let fun curry f x y = f(x,y)
  in
    SOME (first_answer (curry match v) p)
    handle NoAnswer => NONE
  end

