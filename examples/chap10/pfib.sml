fun pfib 0 = 0
  | pfib 1 = 1
  | pfib n =
    if n <= 15
    then pfib (n - 1) + pfib (n - 2)
    else let val t = Myth.Thread.create (fn _ => pfib (n - 2))
         in pfib (n - 1) + Myth.Thread.join t
         end

val t = Timer.startRealTimer ()
val _ = pfib 40
val t = Timer.checkRealTimer t
val _ = print (Real.toString (Time.toReal t) ^ "\n")
