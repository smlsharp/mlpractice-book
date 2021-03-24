type pos = int * int
datatype color = BLACK | WHITE
type board = unit (* 未実装 *)
val get = raise Fail "unimplemented" (* 未実装 *)
val put = raise Fail "unimplemented" (* 未実装 *)
val initBoard = raise Fail "unimplemented" (* 未実装 *)
type game = {board : board, next : color option}
val init = {board = initBoard, next = SOME BLACK}
val step = raise Fail "unimplemented" (* 未実装 *)
fun play moves =
  foldl (fn (pos, NONE) => NONE
          | (pos, SOME game) => step game pos)
        (SOME init)
        moves
