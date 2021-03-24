structure Main =
struct

  fun stringToPos s =
    case map Int.fromString
             (String.tokens Char.isSpace s) of
      [SOME x, SOME y] => SOME (x, y)
    | _ => NONE

  fun readPos () =
    case TextIO.inputLine TextIO.stdIn of
      NONE => NONE
    | SOME s => stringToPos s

  fun colorToString Game.BLACK = "●"
    | colorToString Game.WHITE = "○"
  fun rowToString board y =
    String.concat
      (List.tabulate
         (Game.boardSize,
          fn x => case Game.get board (x, y) of
                    SOME c => colorToString c
                  | NONE => "＿"))
    ^ "\n"
  fun boardToString board =
    String.concat
      (List.tabulate (Game.boardSize, rowToString board))
  fun gameToString {board, next = SOME c} =
      boardToString board ^ colorToString c ^ "の手番です\n"
    | gameToString {board, next = NONE} =
      boardToString board ^ "終局\n"

  fun mainLoop game =
    (print (gameToString game);
     case readPos () of
       NONE => ()
     | SOME pos =>
       case Game.step game pos of
         NONE => ()
       | SOME game => mainLoop game)

end
val _ = Main.mainLoop Game.init
