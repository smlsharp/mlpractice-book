fun init64 () =
  MT.init_genrand64
    (Word64.fromLargeInt (Time.toSeconds (Time.now ())))
val len = 2
val init64 = init64 ()
val randInt63 =
  List.tabulate (len, fn x => MT.genrand64_int63 ())
val randWord64 =
  List.tabulate (len, fn x => MT.genrand64_int64 ())
val randReal1 =
  List.tabulate (len, fn x => MT.genrand64_real1 ())
val randReal2 =
  List.tabulate (len, fn x => MT.genrand64_real2 ())
val randReal3 =
  List.tabulate (len, fn x => MT.genrand64_real3 ())
val _ = Dynamic.pp
        {randInt63 = randInt63, randWord64 = randWord64,
         randReal1 = randReal1, randReal2 = randReal2,
         randReal3 = randReal3}
