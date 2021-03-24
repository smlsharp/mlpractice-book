fun main () =
  let
    val sample = {i = 0, r = 0.0, s = "", il = [0]}
    val arg = GetArg.getArg sample
  in
    Dynamic.pp arg
  end
  handle GetArg.Format => ()
val _ = main ()
