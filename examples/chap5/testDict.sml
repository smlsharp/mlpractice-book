fun fromIntList L = foldl IntDict.enter IntDict.empty L
val iDict = fromIntList [(1, "1"), (2, "2"), (3, "3")]
val a = IntDict.find (iDict, 1)
val b = IntDict.find (iDict, 2)
val c = IntDict.find (iDict, 3)
fun fromStringList L =
    foldl StringDict.enter StringDict.empty L
val sDict = fromStringList [("1", 1), ("2", 2), ("3", 3)]
val d = StringDict.find (sDict, "1")
val e = StringDict.find (sDict, "2")
val f = StringDict.find (sDict, "3")
val _ = Dynamic.pp {a = a, b = b, c = c, d = d, e = e, f = f}
