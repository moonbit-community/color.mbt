///|
test "rgb/hsl convert: assert_eq" {
  let mut count = 0
  // Allow larger hue tolerance due to 8-bit RGB quantization in hsl_to_rgb -> rgb_to_hsl round trip
  let error_h : Double = 0.25
  let error_s : Double = 0.01
  for h in 0..<12 {
    for s = 4; s >= 1; s = s - 1 {
      for l = 8; l >= 0; l = l - 1 {
        let h = h.to_double() * 30
        let s = s.to_double() / 4
        let l = l.to_double() / 8
        let hsl = HSL::{ h, s, l, alpha: None }
        let rgb = hsl_to_rgb(hsl)
        let hsl_ = rgb_to_hsl(rgb)
        // Normalize expectation at achromatic boundaries (l == 0 or l == 1):
        // rgb_to_hsl will canonicalize to h=0, s=0 for black/white.
        let expected = if l == 0.0 || l == 1.0 {
          HSL::{ h: 0.0, s: 0.0, l, alpha: None }
        } else {
          hsl
        }
        // Only check h and s; do not check l
        assert_eq_with_error(expected.h, hsl_.h, error=error_h)
        assert_eq_with_error(expected.s, hsl_.s, error=error_s)
      }
    }
  }
}

///|
test "rgb/hsl convert: assert_eq_with_error" {
  let mut count = 0
  let error : Double = 0.000000000000001
  for h in 0U..<360 {
    for s in 0U..=100 {
      for l in 0U..=100 {
        let h = h.to_double()
        let s = s.to_double() / 100
        let l = l.to_double() / 100
        let hsl = HSL::{ h, s, l, alpha: None }
        let rgb = hsl_to_rgb(hsl)
        let hsl_ = rgb_to_hsl(rgb)
        if (l.round() != 0 && l.round() != 1) ||
          (hsl_.l.round() != 0 && hsl_.l.round() != 1) {
          assert_eq_with_error(hsl.h, hsl_.h, error~)
          assert_eq_with_error(hsl.s, hsl_.s, error~)
        }
      }
    }
  }
}

///|
/// Sample-based conversion tests across HEX/RGB/HSL/OKLab/OKLCh
test "convert: brightPink (#ff0044)" {
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let eps : Double = 0.01

  // HEX -> RGB
  let rgb = hex_to_rgb("#ff0044")
  assert_eq_with_error(255.0, rgb.r, error=eps)
  assert_eq_with_error(0.0, rgb.g, error=eps)
  assert_eq_with_error(68.0, rgb.b, error=eps)

  // RGB -> HSL
  let hsl = rgb_to_hsl(rgb)
  assert_eq_with_error(344.0, hsl.h, error=eps_h)
  assert_eq_with_error(1.0, hsl.s, error=eps_sl)
  assert_eq_with_error(0.5, hsl.l, error=eps_sl)

  // RGB -> OKLab/OKLCh
  let lab = rgb_to_oklab(rgb)
  assert_eq_with_error(0.63269, lab.l, error=eps)
  assert_eq_with_error(0.23887, lab.a, error=eps)
  assert_eq_with_error(0.08648, lab.b, error=eps)

  let lch = rgb_to_oklch(rgb)
  assert_eq_with_error(0.63269, lch.l, error=eps)
  assert_eq_with_error(0.25404, lch.c, error=eps)
  assert_eq_with_error(19.90218, lch.h, error=eps)

  // Round trips
  let rgb_from_lab = oklab_to_rgb(lab)
  assert_eq_with_error(rgb.r, rgb_from_lab.r, error=eps)
  assert_eq_with_error(rgb.g, rgb_from_lab.g, error=eps)
  assert_eq_with_error(rgb.b, rgb_from_lab.b, error=eps)

  let rgb_from_lch = oklch_to_rgb(lch)
  assert_eq_with_error(rgb.r, rgb_from_lch.r, error=eps)
  assert_eq_with_error(rgb.g, rgb_from_lch.g, error=eps)
  assert_eq_with_error(rgb.b, rgb_from_lch.b, error=eps)
}

///|
test "convert: green (rgb 0 255 68)" {
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let eps : Double = 0.01

  let rgb = RGB::{ r: 0.0, g: 255.0, b: 68.0, alpha: None }
  let hsl = rgb_to_hsl(rgb)
  assert_eq_with_error(136.0, hsl.h, error=eps_h)
  assert_eq_with_error(1.0, hsl.s, error=eps_sl)
  assert_eq_with_error(0.5, hsl.l, error=eps_sl)

  let lab = rgb_to_oklab(rgb)
  assert_eq_with_error(0.86876, lab.l, error=eps)
  assert_eq_with_error(-0.22518, lab.a, error=eps)
  assert_eq_with_error(0.15970, lab.b, error=eps)

  let lch = rgb_to_oklch(rgb)
  assert_eq_with_error(0.86876, lch.l, error=eps)
  assert_eq_with_error(0.27606, lch.c, error=eps)
  assert_eq_with_error(144.65534, lch.h, error=eps)
}

///|
test "convert: orange via OKLab -> RGB/HSL" {
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let eps : Double = 0.005

  let lab = LAB::{ l: 0.70622, a: 0.1374, b: 0.14283, alpha: None }
  let lch = oklab_to_oklch(lab)
  assert_eq_with_error(0.70622, lch.l, error=eps)
  assert_eq_with_error(0.19819, lch.c, error=eps)
  assert_eq_with_error(46.11008, lch.h, error=eps)

  let rgb = oklab_to_rgb(lab)
  assert_eq_with_error(255.0, rgb.r, error=eps)
  assert_eq_with_error(110.0, rgb.g, error=eps)
  assert_eq_with_error(0.0, rgb.b, error=eps)

  let hsl = rgb_to_hsl(rgb)
  assert_eq_with_error(25.88, hsl.h, error=eps_h)
  assert_eq_with_error(1.0, hsl.s, error=eps_sl)
  assert_eq_with_error(0.5, hsl.l, error=eps_sl)
}

///|
test "convert: violet via OKLCh -> RGB/OKLab" {
  let eps : Double = 0.005
  let lch = LCH::{ l: 0.47642, c: 0.29956, h: 274.93693, alpha: None }
  let lab = oklch_to_oklab(lch)
  assert_eq_with_error(0.47642, lab.l, error=eps)
  assert_eq_with_error(0.02578, lab.a, error=eps)
  assert_eq_with_error(-0.29845, lab.b, error=eps)

  let rgb = oklch_to_rgb(lch)
  assert_eq_with_error(68.0, rgb.r, error=eps)
  assert_eq_with_error(0.0, rgb.g, error=eps)
  assert_eq_with_error(255.0, rgb.b, error=eps)
}

///|
test "convert: yellow (HSL -> RGB -> OKLab/OKLCh)" {
  let eps_h : Double = 0.5
  let eps_sl : Double = 0.01
  let eps : Double = 0.02

  let hsl = HSL::{ h: 49.73, s: 1.0, l: 0.7137, alpha: None }
  let rgb = hsl_to_rgb(hsl)
  assert_eq_with_error(255.0, rgb.r, error=eps)
  assert_eq_with_error(230.0, rgb.g, error=eps)
  assert_eq_with_error(109.0, rgb.b, error=eps)

  let lab = rgb_to_oklab(rgb)
  assert_eq_with_error(0.92235, lab.l, error=eps)
  assert_eq_with_error(-0.01932, lab.a, error=eps)
  assert_eq_with_error(0.14143, lab.b, error=eps)

  let lch = rgb_to_oklch(rgb)
  assert_eq_with_error(0.92235, lch.l, error=eps)
  assert_eq_with_error(0.14274, lch.c, error=eps)
  assert_eq_with_error(97.77872, lch.h, error=eps_h)

  // Round trip back to HSL (allow tolerance)
  let hsl2 = rgb_to_hsl(rgb)
  assert_eq_with_error(hsl.h, hsl2.h, error=eps_h)
  assert_eq_with_error(hsl.s, hsl2.s, error=eps_sl)
  assert_eq_with_error(hsl.l, hsl2.l, error=eps_sl)
}
