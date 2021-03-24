type vec = real * real * real
fun add (x1, y1, z1) (x2, y2, z2) : vec =
  (x1 + x2, y1 + y2, z1 + z2)
fun sub (x1, y1, z1) (x2, y2, z2) : vec =
  (x1 - x2, y1 - y2, z1 - z2)
fun dot (x1, y1, z1) (x2, y2, z2) : real =
  x1 * x2 + y1 * y2 + z1 * z2
fun scale s (x, y, z) : vec =
  (x * s, y * s, z * s)
fun normal v =
  scale (1.0 / Math.sqrt (dot v v)) v

type ray = {orig : vec, dir : vec}

type sphere = {center : vec, radius : real}
val dummySphere = {center = (0.0, 0.0, 0.0), radius = 0.0}

val width = 1024
val height = 1024
val eye = (0.0, 0.0, 5.0)
val light = normal (1.0, 1.0, 1.0)

fun tree 0 _ _ = nil
  | tree l r (c as (x, y, z)) =
    let val d = 0.8 * r
    in {center = c, radius = r}
       :: tree (l - 1) (0.5 * r) (x - d, y - d, z + d)
       @ tree (l - 1) (0.5 * r) (x + d, y - d, z + d)
    end
val scene = tree 4 1.0 (0.0, 0.6, 0.0)

fun primary (x, y) =
  normal (real x + 0.5 - real width / 2.0,
          ~(real y + 0.5 - real height / 2.0),
          ~(real height))

fun ray_sphere {orig, dir} {center, radius} =
  let val v = sub orig center
      val b = dot dir v
      val s = b * b - dot v v + radius * radius
      val t = ~b - Math.sqrt s
  in if t >= 0.0 then t else Real.posInf
  end

fun intersect (ray as {orig, dir}) =
  let val (t, {center, ...}) =
        foldl (fn (x, z) => if #1 x < #1 z then x else z)
              (Real.posInf, dummySphere)
              (map (fn s => (ray_sphere ray s, s)) scene)
      val p = add orig (scale t dir)
      val n = normal (sub p center)
  in (t, p, n)
  end

fun shadow p =
  #1 (intersect {orig = p, dir = light}) < Real.posInf

fun pixel pos =
  let val ray = {orig = eye, dir = primary pos}
      val (t, p, n) = intersect ray
  in if t >= Real.posInf then 0.0 else
     let val v = dot n light
     in if v <= 0.0 orelse shadow p then 0.0 else v
     end
  end

val image = Word8Array.array (width * height, 0w0)

fun set (x, y) r =
  Word8Array.update
    (image, x + width * y,
     Word8.fromInt (Int.min (trunc (r * 255.0), 255)))

fun loop (x, w) f =
  if w <= 0 then () else (f x; loop (x + 1, w - 1) f)
fun rayTrace (x, y, w, h) =
  loop (y, h)
       (fn y =>
          loop (x, w)
               (fn x => set (x, y) (pixel (x, y))))

fun writeImage filename =
  let val f = BinIO.openOut filename
      val w = Int.toString width
      val h = Int.toString height
      val head = "P5\n" ^ w ^ " " ^ h ^ " 255\n"
  in BinIO.output (f, Byte.stringToBytes head);
     BinIO.output (f, Word8Array.vector image);
     BinIO.closeOut f
  end

val _ = rayTrace (0, 0, width, height)
val _ = writeImage "out.ppm"
