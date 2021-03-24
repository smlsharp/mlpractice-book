structure Game =
struct

  type pos = int * int

  datatype color = BLACK | WHITE

  type board = (pos * color) list

  val initBoard =
    [((3, 3), WHITE), ((4, 3), BLACK),
     ((3, 4), BLACK), ((4, 4), WHITE)]

  fun get nil _ = NONE
    | get ((p, c) :: t) pos =
      if p = pos then SOME c else get t pos

  fun put nil pos color = [(pos, color)]
    | put ((p, c) :: t) pos color =
      if p = pos then (p, color) :: t
      else (p, c) :: put t pos color

  type game = {board : board, next : color option}

  val init = {board = initBoard, next = SOME BLACK}

  fun flipDir’ board color (x, y) (dir as (dx, dy)) =
    let val pos = (x + dx, y + dy)
    in case get board pos of
         NONE => NONE
       | SOME c =>
         if c = color
         then SOME nil
         else case flipDir’ board color pos dir of
                NONE => NONE
              | SOME t => SOME (pos :: t)
    end

  fun flipDir board color pos dir =
    getOpt (flipDir’ board color pos dir, nil)

  val directions =
    [(~1, ~1), ( 0, ~1), ( 1, ~1), (~1,  0),
     (1, 0),(~1, 1),(0, 1),(1, 1)]

  fun flip board color pos =
    case get board pos of
     SOME _ => nil
   | NONE =>
     List.concat (map (flipDir board color pos) directions)

  fun opponent BLACK = WHITE
    | opponent WHITE = BLACK

  val boardSize = 8
  val allPos =
    List.tabulate
      (boardSize * boardSize,
       fn i => (i mod boardSize, i div boardSize))

  fun possible board color =
    List.filter
      (fn pos => not (null (flip board color pos)))
      allPos

  fun next board color =
    case possible board (opponent color) of
      _ :: _ => SOME (opponent color)
    | nil =>
      case possible board color of
        _ :: _ => SOME color
      | nil => NONE

  fun move board color positions =
    foldl (fn (pos, board) => put board pos color)
          board
          positions

  fun step {next = NONE, ...} _ = NONE
    | step {board, next = SOME color} pos =
      case flip board color pos of
        nil => NONE
      | positions =>
        let val b = move board color (pos :: positions)
        in SOME {board = b, next = next b color}
        end

  fun play moves =
    foldl (fn (pos, NONE) => NONE
            | (pos, SOME game) => step game pos)
          (SOME init)
          moves

end
