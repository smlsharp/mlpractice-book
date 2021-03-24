structure Graph =
struct
  open Draw

  fun tick (min, max) =
    let
      val w = (max - min) / 2.0
      val e = Math.pow (10.0, Real.realFloor (Math.log10 w))
      val s = w / e
      val step = if s >= 5.0 then 5.0 * e
                 else if s >= 2.0 then 2.0 * e
                 else e
    in
      {min = Real.realFloor (min / step) * step, step = step}
    end

  fun tickLabel r = Real.fmt (StringCvt.GEN (SOME 4)) r
  fun ticks max min step scale offset =
    List.tabulate
      (trunc ((max - min) / step + 1.00001),
       fn i => (step * real i * scale + offset,
                tickLabel (step * real i + min)))
  fun drawAxes points =
    let
      val xmax = foldl Real.max Real.negInf (map #x points)
      val xmin = foldl Real.min Real.posInf (map #x points)
      val ymax = foldl Real.max Real.negInf (map #y points)
      val ymin = foldl Real.min Real.posInf (map #y points)
      val {min = xmin, step = xstep} = tick (xmin, xmax)
      val {min = ymin, step = ystep} = tick (ymin, ymax)
      val xscale = 0.8 / (xmax - xmin)
      val yscale = ~0.8 / (ymax - ymin)
      val xoffset = 0.1 + 0.025
      val yoffset = 0.9 - 0.025
      val xs = ticks xmax xmin xstep xscale xoffset
      val ys = ticks ymax ymin ystep yscale yoffset
      val xt = map (fn (x,_) => LINES [(x, 0.9), (x, 0.93)]) xs
      val yt = map (fn (y,_) => LINES [(0.07, y), (0.1, y)]) ys
      val xl = map (fn (x, s) => TEXT (x, 0.96, s)) xs
      val yl = map (fn (y, s) =>
                      MOVE (0.04, y,
                            ROTATE (270.0,
                                    TEXT (0.0, 0.0, s))))
                   ys
    in
      {xpos = fn x => (x - xmin) * xscale + xoffset,
       ypos = fn y => (y - ymin) * yscale + yoffset,
       obj = [STROKE (COMBINE [RECT (0.1, 0.05, 0.85, 0.85),
                               COMBINE xt, COMBINE yt]),
              FILL (COMBINE [COMBINE xl, COMBINE yl])]}
    end

  fun plot points =
    let
      val {xpos, ypos, obj} = drawAxes points
      val ps = map (fn {x, y} => CIRCLE (xpos x, ypos y, 0.01))
                   points
    in
      STROKE (COMBINE ps) :: obj
    end

end
