(* comments*)

val x = 35;

val y = 20;


val z = (x + y)* (x - y);

val abs_z = if z < 0 then 0 - z else z;
val diff_z = abs z;

val q = if z > y then z + y else y + x;
