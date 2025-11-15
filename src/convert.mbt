///|
/// Compute the positive modulo of x by y so the result is in [0, y).
/// - params: x is any real number; y > 0
/// - returns: positive modulo as Double
fn mod(x : Double, y : Double) -> Double {
  if x < 0 {
    (x + y) % y
  } else {
    x % y
  }
}

///|
/// Return the sign of a real number.
/// - x > 0 => 1.0; x < 0 => -1.0; x == 0 => 0.0
fn sign(x : Double) -> Double {
  if x > 0.0 {
    1.0
  } else if x < 0.0 {
    -1.0
  } else {
    0.0
  }
}

///|
/// Clamp a value into the interval [min, max].
/// - defaults: [0, 100]
/// - returns: min if value < min; max if value > max; otherwise value
fn clamp(value : Double, min? : Double = 0, max? : Double = 100) -> Double {
  @cmp.minimum(@cmp.maximum(value, min), max)
}

///|
/// Round a floating-point number to a given precision.
/// - precision: number of fractional digits to keep (default 2)
/// - force_precision: when true, round exactly to precision; when false, choose digits adaptively by magnitude
/// - returns: rounded result
fn round(
  input : Double,
  precision? : Int = 2,
  force_precision? : Bool = true,
) -> Double {
  if input == 0.0 {
    return 0.0
  }
  if force_precision {
    let factor = @math.pow(10.0, precision.to_double())
    return @math.round(input * factor) / factor
  }
  let abs_input = Double::abs(input)
  let mut digits = Double::abs(@math.ceil(@math.log10(abs_input))).to_int()
  if digits == 0 {
    digits = 2
  } else if digits > precision {
    digits = precision
  }
  let mut exponent = precision - (if digits < 0 { 0 } else { digits })
  if exponent <= 1 && precision > 1 {
    exponent = 2
  } else if exponent > precision || exponent == 0 {
    exponent = precision
  }
  let factor = @math.pow(10.0, exponent.to_double())
  @math.round(input * factor) / factor
}

///|
/// Convert an 8-bit sRGB channel to linear RGB (inverse gamma).
/// - param: c in [0, 255]
/// - returns: linear-space Double, approximately in [-1, 1]
fn rgb_to_linear(c : UInt) -> Double {
  let input = c.to_double() / 255.0
  let absval = Double::abs(input)
  if absval < 0.04045 {
    input / 12.92
  } else {
    let base = (absval + 0.055) / 1.055
    let lin = @math.pow(base, 2.4)
    (if sign(input) == 0.0 { 1.0 } else { sign(input) }) * lin
  }
}

///|
/// Convert a linear RGB channel value to sRGB (gamma encode).
/// - param: input is a linear-space value
/// - returns: sRGB-space Double (not scaled to 0–255)
fn linear_to_rgb(input : Double) -> Double {
  let absolute_number = Double::abs(input)
  let sign_value = if input < 0.0 { -1.0 } else { 1.0 }
  if absolute_number > 0.0031308 {
    let v = @math.pow(absolute_number, 1.0 / 2.4) * 1.055 - 0.055
    sign_value * v
  } else {
    input * 12.92
  }
}

///|
/// Parse a hex color string to RGB.
/// - input format: "#RRGGBB" (case-insensitive)
/// - on failure: raises a parse error
pub fn hex_to_rgb(input : StringView) -> RGB raise {
  let r = @strconv.parse_uint(input[1:3], base=16)
  let g = @strconv.parse_uint(input[3:5], base=16)
  let b = @strconv.parse_uint(input[5:], base=16)
  RGB::{ r, g, b, alpha: None }
}

///|
/// Convert RGB to HSL (alpha ignored).
/// - input: r,g,b in [0,255]
/// - output: h in [0,360), s,l in [0,1]
pub fn rgb_to_hsl(rgb : RGB) -> HSL {
  let r = rgb.r.to_double() / 255
  let g = rgb.g.to_double() / 255
  let b = rgb.b.to_double() / 255
  let x_max = @cmp.maximum(r, @cmp.maximum(g, b))
  let v = x_max
  let x_min = @cmp.minimum(r, @cmp.minimum(g, b))
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
  HSL::{ h, s, l, alpha: None }
}

///|
/// Convert RGB to a hex string (alpha ignored).
/// - returns: "rrggbb" (no leading #)
pub fn rgb_to_hex(rgb : RGB) -> HEX {
  "\{rgb.r.to_string(radix=16)}\{rgb.g.to_string(radix=16)}\{rgb.b.to_string(radix=16)}"
}

///|
/// Convert RGB to Oklab and round components.
/// - precision: number of fractional digits, default PRECISION
pub fn rgb_to_oklab(rgb : RGB, precision? : Int = PRECISION) -> LAB {
  let lr = rgb_to_linear(rgb.r)
  let lg = rgb_to_linear(rgb.g)
  let lb = rgb_to_linear(rgb.b)
  let l = @math.cbrt(
    lrgb_to_lms.l.0 * lr + lrgb_to_lms.l.1 * lg + lrgb_to_lms.l.2 * lb,
  )
  let m = @math.cbrt(
    lrgb_to_lms.m.0 * lr + lrgb_to_lms.m.1 * lg + lrgb_to_lms.m.2 * lb,
  )
  let s = @math.cbrt(
    lrgb_to_lms.s.0 * lr + lrgb_to_lms.s.1 * lg + lrgb_to_lms.s.2 * lb,
  )
  let ok_l = lsm_to_lab.l.0 * l + lsm_to_lab.l.1 * m - lsm_to_lab.l.2 * s
  let ok_a = lsm_to_lab.a.0 * l - lsm_to_lab.a.1 * m + lsm_to_lab.a.2 * s
  let ok_b = lsm_to_lab.b.0 * l + lsm_to_lab.b.1 * m - lsm_to_lab.b.2 * s
  LAB::{
    l: round(ok_l, precision~),
    a: round(ok_a, precision~),
    b: round(ok_b, precision~),
    alpha: None,
  }
}

///|
/// Convert RGB to Oklch.
/// - Equivalent to rgb_to_oklab followed by oklab_to_oklch
pub fn rgb_to_oklch(rgb : RGB, precision? : Int = PRECISION) -> LCH {
  return oklab_to_oklch(rgb_to_oklab(rgb, precision~), precision~)
}

///|
/// Convert HSL to RGB.
/// - input: h in [0,360), s,l in [0,1]
/// - output: r,g,b in [0,255]
pub fn hsl_to_rgb(hsl : HSL) -> RGB {
  let h = hsl.h
  let s = hsl.s
  let l = hsl.l
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
    /// Add the offset m to a normalized channel
    v + m
  }

  RGB::from_double(aux(r), aux(g), aux(b))
}

///|
/// Convert HSL to a hex color string.
pub fn hsl_to_hex(hsl : HSL) -> HEX {
  rgb_to_hex(hsl_to_rgb(hsl))
}

///|
/// Convert HSL to Oklab.
pub fn hsl_to_oklab(hsl : HSL, precision? : Int = PRECISION) -> LAB {
  rgb_to_oklab(hsl_to_rgb(hsl), precision~)
}

///|
/// Convert HSL to Oklch.
pub fn hsl_to_oklch(hsl : HSL, precision? : Int = PRECISION) -> LCH {
  rgb_to_oklch(hsl_to_rgb(hsl), precision~)
}

///|
/// Convert Oklab to Oklch and round components.
/// - Set h to 0 when c is near 0
pub fn oklab_to_oklch(lab : LAB, precision? : Int = PRECISION) -> LCH {
  let l = lab.l
  let a = lab.a
  let b = lab.b
  let c = Double::sqrt(@math.pow(a, 2) + @math.pow(b, 2))
  let mut h = (@math.atan2(b, a) * RAD2DEG + 360) % 360
  if round(c * 10000) == 0 {
    h = 0
  }
  LCH::{
    l: round(l, precision~),
    c: round(c, precision~),
    h: round(h, precision~),
    alpha: None,
  }
}

///|
/// Convert Oklab to a hex color string.
pub fn oklab_to_hex(lab : LAB, precision? : Int = PRECISION) -> HEX {
  rgb_to_hex(oklab_to_rgb(lab, precision~))
}

///|
/// Convert Oklab to HSL.
pub fn oklab_to_hsl(lab : LAB, precision? : Int = PRECISION) -> HSL {
  rgb_to_hsl(oklab_to_rgb(lab, precision~))
}

///|
/// Convert Oklab to RGB, then clamp and round the result.
/// - precision: fractional digits to round before clamping
pub fn oklab_to_rgb(lab : LAB, precision? : Int = PRECISION) -> RGB {
  let l = lab.l
  let a = lab.a
  let b = lab.b
  let _l = @math.pow(l + lab_to_lms.l.0 * a + lab_to_lms.l.1 * b, 3)
  let _m = @math.pow(l + lab_to_lms.m.0 * a + lab_to_lms.m.1 * b, 3)
  let _s = @math.pow(l + lab_to_lms.s.0 * a + lab_to_lms.s.1 * b, 3)
  let r = linear_to_rgb(
      lsm_to_rgb.r.0 * _l + lsm_to_rgb.r.1 * _m + lsm_to_rgb.r.2 * _s,
    ) *
    255
  let g = linear_to_rgb(
      lsm_to_rgb.g.0 * _l + lsm_to_rgb.g.1 * _m + lsm_to_rgb.g.2 * _s,
    ) *
    255
  let b = linear_to_rgb(
      lsm_to_rgb.b.0 * _l + lsm_to_rgb.b.1 * _m + lsm_to_rgb.b.2 * _s,
    ) *
    255
  RGB::{
    r: clamp(round(r, precision~), min=0, max=255).to_uint(),
    g: clamp(round(g, precision~), min=0, max=255).to_uint(),
    b: clamp(round(b, precision~), min=0, max=255).to_uint(),
    alpha: None,
  }
}

///|
/// Convert Oklch to Oklab and round components.
/// - h is in degrees; if h < 0 it is clamped to 0
/// - a/b are computed from c and h using trigonometry
pub fn oklch_to_oklab(lch : LCH, precision? : Int = PRECISION) -> LAB {
  let l = lch.l
  let c = lch.c
  let mut h = lch.h
  if h < 0 {
    h = 0
  }
  LAB::{
    l: round(l, precision~),
    a: round(c * @math.cos(h * DEG2RAD), precision~),
    b: round(c * @math.sin(h * DEG2RAD), precision~),
    alpha: None,
  }
}

///|
/// Convert Oklch to RGB.
pub fn oklch_to_rgb(lch : LCH, precision? : Int = PRECISION) -> RGB {
  oklab_to_rgb(oklch_to_oklab(lch, precision~), precision~)
}

///|
/// Convert Oklch to a hex color string.
pub fn oklch_to_hex(lch : LCH, precision? : Int = PRECISION) -> HEX {
  rgb_to_hex(oklch_to_rgb(lch, precision~))
}

///|
/// Convert Oklch to HSL.
pub fn oklch_to_hsl(lch : LCH, precision? : Int = PRECISION) -> HSL {
  rgb_to_hsl(oklch_to_rgb(lch, precision~))
}
