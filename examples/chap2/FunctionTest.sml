structure FunctionTest =
struct
  fun sum n =
    let
      fun L (0, s) = s : int64
        | L (i, s) = L (i - 1, s + i)
    in
      L (n, 0)
    end
  fun power m n =
    let
      fun L (0, a) = a
        | L (m, a) = L (m - 1, a * n)
    in
      L (m, 1)
    end
  val cube = power 3
  fun Sigma f n =
    let
      fun L (0, a) = a
        | L (n, a) = L (n - 1, a + f n)
    in
      L (n, 0)
    end
  val sumCubeSigma = Sigma cube
end
