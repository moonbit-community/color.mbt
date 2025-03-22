///|
test "rgb/hsl convert: assert_eq" {
  let mut count = 0
  for h in 0..<12 {
    for s = 4; s >= 1; s = s - 1 {
      for l = 8; l >= 0; l = l - 1 {
        let h = h.to_double() * 30
        let s = s.to_double() / 4
        let l = l.to_double() / 8
        let (r, g, b) = hsl_to_rgb(h, s, l)
        let (h_, s_, l_) = rgb_to_hsl(r, g, b)
        assert_eq!(l, l_)
        if (l != 0 && l != 1) || (l_ != 0 && l_ != 1) {
          assert_eq!(h, h_)
          assert_eq!(s, s_)
        }
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
        let (r, g, b) = hsl_to_rgb(h, s, l)
        let (h_, s_, l_) = rgb_to_hsl(r, g, b)
        assert_eq_with_error!(l, l_, error~)
        if (l.round() != 0 && l.round() != 1) ||
          (l_.round() != 0 && l_.round() != 1) {
          assert_eq_with_error!(h, h_, error~)
          assert_eq_with_error!(s, s_, error~)
        }
      }
    }
  }
}
