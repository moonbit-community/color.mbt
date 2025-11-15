///|
/// Tests for parse_color_string

///|
test "parse_color_string: hex long #ff0044" {
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let eps : Double = 0.01
  let c = parse_color_string("#ff0044")
  // basic fields
  assert_eq_str(c.color_type, "hex")
  assert_eq_str(c.hex, "#ff0044")
  assert_true(c.alpha is None)

  // rgb
  assert_eq_with_error(255.0, c.rgb.r, error=eps)
  assert_eq_with_error(0.0, c.rgb.g, error=eps)
  assert_eq_with_error(68.0, c.rgb.b, error=eps)

  // hsl
  assert_eq_with_error(344.0, c.hsl.h, error=eps_h)
  assert_eq_with_error(1.0, c.hsl.s, error=eps_sl)
  assert_eq_with_error(0.5, c.hsl.l, error=eps_sl)

  // oklab / oklch
  assert_eq_with_error(0.63269, c.oklab.l, error=eps)
  assert_eq_with_error(0.23887, c.oklab.a, error=eps)
  assert_eq_with_error(0.08648, c.oklab.b, error=eps)
  assert_eq_with_error(0.63269, c.oklch.l, error=eps)
  assert_eq_with_error(0.25404, c.oklch.c, error=eps)
  assert_eq_with_error(19.90218, c.oklch.h, error=eps)
}

///|
test "parse_color_string: hex short #f04" {
  let eps : Double = 0.01
  let c = parse_color_string("#f04")
  assert_eq_str(c.color_type, "hex")
  // short hex should normalize to long form
  assert_eq_str(c.hex, "#ff0044")
  assert_true(c.alpha is None)
  assert_eq_with_error(255.0, c.rgb.r, error=eps)
  assert_eq_with_error(0.0, c.rgb.g, error=eps)
  assert_eq_with_error(68.0, c.rgb.b, error=eps)
}

///|
test "parse_color_string: hex short with alpha #f044" {
  let eps : Double = 0.00001
  let c = parse_color_string("#f044")
  assert_eq_str(c.color_type, "hex")
  assert_eq_str(c.hex, "#ff0044")
  // alpha = 0x44 / 255
  assert_eq_with_error(68.0 / 255.0, c.alpha.unwrap(), error=eps)
  assert_eq_with_error(68.0 / 255.0, c.rgb.alpha.unwrap(), error=eps)
}

///|
test "parse_color_string: hex long with alpha #ff00447f" {
  let eps : Double = 0.00001
  let c = parse_color_string("#ff00447f")
  assert_eq_str(c.color_type, "hex")
  assert_eq_str(c.hex, "#ff0044")
  assert_eq_with_error(127.0 / 255.0, c.alpha.unwrap(), error=eps)
}

///|
test "parse_color_string: rgb() without alpha" {
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let eps : Double = 0.01
  let c = parse_color_string("rgb(255, 0, 68)")
  assert_eq_str(c.color_type, "rgb")
  assert_true(c.alpha is None)
  assert_eq_with_error(255.0, c.rgb.r, error=eps)
  assert_eq_with_error(0.0, c.rgb.g, error=eps)
  assert_eq_with_error(68.0, c.rgb.b, error=eps)

  // derived HSL should be consistent
  assert_eq_with_error(344.0, c.hsl.h, error=eps_h)
  assert_eq_with_error(1.0, c.hsl.s, error=eps_sl)
  assert_eq_with_error(0.5, c.hsl.l, error=eps_sl)
}

///|
test "parse_color_string: rgba() numeric alpha" {
  let eps : Double = 0.00001
  let c = parse_color_string("rgba(255,0,68,0.5)")
  assert_eq_str(c.color_type, "rgb")
  assert_eq_with_error(0.5, c.alpha.unwrap(), error=eps)
  assert_eq_with_error(255.0, c.rgb.r, error=0.01)
  assert_eq_with_error(0.0, c.rgb.g, error=0.01)
  assert_eq_with_error(68.0, c.rgb.b, error=0.01)
}

///|
test "parse_color_string: rgb() with slash percent alpha" {
  let eps : Double = 0.00001
  let c = parse_color_string("rgb(255 0 68 / 50%)")
  assert_eq_str(c.color_type, "rgb")
  assert_eq_with_error(0.5, c.alpha.unwrap(), error=eps)
}

///|
/// Tests for parse_color_string on hsl/oklab/oklch forms

///|
test "parse_color_string: hsl no alpha" {
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let eps : Double = 0.02
  let c = parse_color_string("hsl(49.73, 100%, 71.37%)")
  assert_eq_str(c.color_type, "hsl")
  assert_true(c.alpha is None)
  // HSL preserved
  assert_eq_with_error(49.73, c.hsl.h, error=eps_h)
  assert_eq_with_error(1.0, c.hsl.s, error=eps_sl)
  assert_eq_with_error(0.7137, c.hsl.l, error=eps_sl)
  // Derived RGB approx
  assert_eq_with_error(255.0, c.rgb.r, error=eps)
  assert_eq_with_error(230.0, c.rgb.g, error=eps)
  assert_eq_with_error(109.0, c.rgb.b, error=eps)
}

///|
test "parse_color_string: hsla percent alpha" {
  let eps : Double = 0.00001
  let c = parse_color_string("hsla(344,100%,50%,25%)")
  assert_eq_str(c.color_type, "hsl")
  assert_eq_with_error(0.25, c.alpha.unwrap(), error=eps)
  assert_eq_with_error(0.25, c.hsl.alpha.unwrap(), error=eps)
}

///|
/// OKLab uses L% then a, b as numbers
test "parse_color_string: oklab no alpha" {
  let eps : Double = 0.01
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let c = parse_color_string("oklab(70.622% 0.1374 0.14283)")
  assert_eq_str(c.color_type, "oklab")
  assert_true(c.alpha is None)
  // LAB preserved
  assert_eq_with_error(0.70622, c.oklab.l, error=eps)
  assert_eq_with_error(0.1374, c.oklab.a, error=eps)
  assert_eq_with_error(0.14283, c.oklab.b, error=eps)
  // Derived RGB/HSL checks
  assert_eq_with_error(255.0, c.rgb.r, error=0.02)
  assert_eq_with_error(110.0, c.rgb.g, error=0.02)
  assert_eq_with_error(0.0, c.rgb.b, error=0.02)
  assert_eq_with_error(25.88, c.hsl.h, error=eps_h)
  assert_eq_with_error(1.0, c.hsl.s, error=eps_sl)
  assert_eq_with_error(0.5, c.hsl.l, error=eps_sl)
}

///|
/// OKLCh uses L% then c and h
test "parse_color_string: oklch with numeric alpha" {
  let eps : Double = 0.005
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let c = parse_color_string("oklch(70.622% 0.19819 46.11008 / 0.5)")
  assert_eq_str(c.color_type, "oklch")
  assert_eq_with_error(0.5, c.alpha.unwrap(), error=0.00001)
  // LCH preserved
  assert_eq_with_error(0.70622, c.oklch.l, error=eps)
  assert_eq_with_error(0.19819, c.oklch.c, error=eps)
  assert_eq_with_error(46.11008, c.oklch.h, error=eps)
  // RGB ~ orange
  assert_eq_with_error(255.0, c.rgb.r, error=0.02)
  assert_eq_with_error(110.0, c.rgb.g, error=0.02)
  assert_eq_with_error(0.0, c.rgb.b, error=0.02)
  // HSL
  assert_eq_with_error(25.88, c.hsl.h, error=eps_h)
  assert_eq_with_error(1.0, c.hsl.s, error=eps_sl)
  assert_eq_with_error(0.5, c.hsl.l, error=eps_sl)
}
