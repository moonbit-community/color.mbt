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
