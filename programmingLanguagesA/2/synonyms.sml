datatype suit Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank
type name_recod = {student_num : int option,
		   first : string,
		   middle : string option,
		   last : string }
datatype ('a,'b) binary_tree = Node of 'a * ('a, 'b) tree * ('a, 'b) tree
			     | Leaf of 'b

fun sum_tree tr =
    case tr of
	Leaf i => i
      | Node(i, lft, rgt) => i + sum_tree lft + sum_tree rgt


fun sum_leaves tr =
    case tr of
	Leaf i => i
      | Node(i, lft, rgt) => sum_leaves lft + sum_leaves rgt						     
		      
fun num_leaves tr =
    case tr of
	Leaf i => 1
      | Node(i, lft, rgt) => sum_leaves lft + sum_leaves rgt				   
fun zip list_triple =
    case list_triple of
	([],[],[]) => []
      | (hd1::tl1,hd2::tls,hd3::tl3) => (hd1,hd2,hd3)::zip(tl1,tl2,tl3)
      | _ => raise ListLengthMismatch


fun unzip lst =
    case lst of
	[] => ([],[],[])
      | (a,b,c)::tl =>let val (l1,l2,l3) = unzip tl
		      in
			  (a::l1,b::l2,c::l3)
		      end

