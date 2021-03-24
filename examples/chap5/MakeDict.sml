structure MakeDict =
struct
  type ('key, 'value) dict = ('key * 'value) list
  exception Empty
  fun makeDict comp =
    let
      val empty = nil
      fun find (dict, key) =
          case dict of
            nil => raise Empty
          | ((k, v) :: tl) =>
            (case comp (k, key) of
               EQUAL => v
             | _ => find (tl, key))
      fun enter ((k, v), dict) = (k, v) :: dict
    in
      {find = find,  empty = empty,  enter = enter}
    end
end
