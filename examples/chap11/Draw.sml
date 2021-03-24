structure Draw =
struct
  open Cairo

  datatype path =
      LINES of (real * real) list
    | RECT of real * real * real * real
    | CIRCLE of real * real * real
    | TEXT of real * real * string
    | MOVE of real * real * path
    | SCALE of real * real * path
    | ROTATE of real * path
    | COMBINE of path list
  datatype obj =
      STROKE of path
    | FILL of path

  fun evalPath c (COMBINE l) =
      app (evalPath c) l
    | evalPath c (MOVE (x, y, path)) =
      (cairo_save c;
       cairo_translate (c, x, y);
       evalPath c path;
       cairo_restore c)
    | evalPath c (SCALE (x, y, path)) =
      (cairo_save c;
       cairo_scale (c, x, y);
       evalPath c path;
       cairo_restore c)
    | evalPath c (ROTATE (d, path)) =
      (cairo_save c;
       cairo_rotate (c, d * Math.pi / 180.0);
       evalPath c path;
       cairo_restore c)
    | evalPath c (LINES nil) = ()
    | evalPath c (LINES ((x, y) :: t)) =
      (cairo_move_to (c, x, y);
       app (fn (x, y) => cairo_line_to (c, x, y)) t)
    | evalPath c (RECT (x, y, w, h)) =
      cairo_rectangle (c, x, y, w, h)
    | evalPath c (CIRCLE (x, y, r)) =
      (cairo_new_sub_path c;
       cairo_arc (c, x, y, r, 0.0, 2.0 * Math.pi))
    | evalPath c (TEXT (x, y, s)) =
      let
        val d = Array.array (6, 0.0)
        val _ = cairo_text_extents (c, s, d)
        val dx = Array.sub (d, 0) + Array.sub (d, 2) / 2.0
        val dy = Array.sub (d, 1) + Array.sub (d, 3) / 2.0
      in
        cairo_move_to (c, x - dx, y - dy);
        cairo_text_path (c, s)
      end
  fun evalObj c (FILL path) = (evalPath c path; cairo_fill c)
    | evalObj c (STROKE path) = (evalPath c path; cairo_stroke c)

  fun toPDF filename objs =
    let
      val s = cairo_pdf_surface_create (filename, 144.0, 144.0)
      val c = cairo_create s
    in
      cairo_set_source_rgb (c, 1.0, 1.0, 1.0);
      cairo_paint c;
      cairo_set_source_rgb (c, 0.0, 0.0, 0.0);
      cairo_scale (c, 144.0, 144.0);
      cairo_set_font_size (c, 0.05);
      cairo_set_line_width (c, 0.0025);
      app (evalObj c) objs;
      cairo_destroy c;
      cairo_surface_destroy s
    end

end
