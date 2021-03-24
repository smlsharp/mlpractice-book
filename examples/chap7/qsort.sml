type size_t = word64
fun 'a#unboxed qsort (array, compare) =
  let
    val qsort_c =
        _import "qsort"
        : ('a array, size_t, 'a size, ('a ptr, 'a ptr) -> int) 
            -> ()
  in
    qsort_c (array,
             Word64.fromInt (Array.length array),
             _sizeof('a),
             compare)
  end
fun compare (p1, p2) =
  let
    val n1 = Pointer.load p1
    val n2 = Pointer.load p2
  in
    if n1 > n2 then 1 else if n1 < n2 then ~1 else 0
  end
;
val a = Array.tabulate (10, fn x => 10 -x);
val _ = qsort (a, compare);
val _ = Dynamic.pp a;
