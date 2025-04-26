fun sum_list(ls: int list) =
    if null ls
    then 0
    else hd ls + sum_list(tl ls);

fun countdown(x : int) =
    if x = 0
    then []
    else x::countdown(x-1);

fun append (x : int list, y int list) =
    if null x
    then y
    else (hd x) :: (append((tl x), y));
