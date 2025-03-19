///|
fn mod(x : Double, y : Double) -> Double {
  if x < 0 {
    (x + y) % y
  } else {
    x % y
  }
}

///|
/// * r in \[0,1\]
/// 
/// * g in \[0,1\]
/// 
/// * b in \[0,1\]
pub fn rgb_to_hsl(
  r : Double,
  g : Double,
  b : Double
) -> (Double, Double, Double) {
  let x_max = @math.maximum(r, @math.maximum(g, b))
  let v = x_max
  let x_min = @math.minimum(r, @math.minimum(g, b))
  let c = x_max - x_min
  let l = (x_max + x_min) / 2
  let h = if c == 0 {
    0.0
  } else if v == r {
    60.0 * mod((g - b) / c, 6)
  } else if v == g {
    60.0 * ((b - r) / c + 2)
  } else if v == b {
    60.0 * ((r - g) / c + 4)
  } else {
    abort("unreachable")
  }
  let s = if l == 0 || l == 1 {
    0.0
  } else {
    2.0 * (v - l) / (1.0 - Double::abs(2.0 * l - 1))
  }
  (h, s, l)
}

///|
/// h in \[0,360)
/// 
/// s in \[0,1\]
/// 
/// l in \[0,1\]
pub fn hsl_to_rgb(
  h : Double,
  s : Double,
  l : Double
) -> (Double, Double, Double) {
  let c = (1.0 - Double::abs(2.0 * l - 1.0)) * s
  let h_ = h / 60
  let x = c * (1.0 - Double::abs(h_ % 2.0 - 1.0))
  let m = l - c / 2.0
  let (r, g, b) = match h_.to_int() {
    0 => (c, x, 0.0)
    1 => (x, c, 0.0)
    2 => (0.0, c, x)
    3 => (0.0, x, c)
    4 => (x, 0.0, c)
    5 => (c, 0.0, x)
    _ => abort("unreachable")
  }
  fn aux(v : Double) -> Double {
    v + m
  }

  (aux(r), aux(g), aux(b))
}
