///|
pub fn Color::red(self : Color) -> Byte {
  ((self._ >> 24) & 0xFFU).to_byte()
}

///|
pub fn Color::green(self : Color) -> Byte {
  ((self._ >> 16) & 0xFFU).to_byte()
}

///|
pub fn Color::blue(self : Color) -> Byte {
  ((self._ >> 8) & 0xFFU).to_byte()
}

///|
pub fn Color::alpha(self : Color) -> Byte {
  (self._ & 0xFFU).to_byte()
}

///|
/// * `red` in \[0,255\]
/// 
/// * `green` in \[0,255\]
/// 
/// * `blue` in \[0,255\]
/// 
/// * `alpha` in \[0,255\]
pub fn Color::rgba(
  red : Byte,
  green : Byte,
  blue : Byte,
  alpha : Byte
) -> Color {
  (red.to_uint() << 24) |
  (green.to_uint() << 16) |
  (blue.to_uint() << 8) |
  alpha.to_uint()
}

///|
test "rgba" {
  let color = Color::rgba(0x00, 0x10, 0x20, 0x30)
  inspect!(color.red(), content="b'\\x00'")
  inspect!(color.green(), content="b'\\x10'")
  inspect!(color.blue(), content="b'\\x20'")
  inspect!(color.alpha(), content="b'\\x30'")
}

///|
fn validate_hsla(
  hue : UInt,
  saturation : UInt,
  lightness : UInt,
  alpha : UInt
) -> Unit! {
  assert_true!(hue < 360)
  assert_true!(saturation <= 100)
  assert_true!(lightness <= 100)
  assert_true!(alpha <= 100)
}

///| 
/// * `hue` in \[0,360)
/// 
/// * `saturation` in \[0,100\]
/// 
/// * `lightness` in \[0,100\]
/// 
/// * `alpha` in \[0,100\]
/// 
/// [wiki](https://en.wikipedia.org/wiki/HSL_and_HSV)
pub fn Color::hsla(
  hue : UInt,
  saturation : UInt,
  lightness : UInt,
  alpha : UInt
) -> Color! {
  validate_hsla!(hue, saturation, lightness, alpha)
  let h = hue.to_double()
  let s = saturation.to_double() / 100
  let l = lightness.to_double() / 100
  let a = alpha.to_double() / 100
  fn to_byte(v : Double) -> Byte {
    (v * 255.0).round().to_int().to_byte()
  }

  let (r, g, b) = hsl_to_rgb(h, s, l)
  Color::rgba(
    to_byte(r),
    to_byte(g),
    to_byte(b),
    (a * 255.0).to_uint().to_byte(),
  )
}

///|
pub fn Color::rgb(red : Byte, green : Byte, blue : Byte) -> Color {
  Color::rgba(red, green, blue, 255)
}

///|
pub fn Color::hsl(hue : UInt, saturation : UInt, lightness : UInt) -> Color! {
  Color::hsla!(hue, saturation, lightness, 100)
}

///|
pub impl Show for Color with output(self, logger) {
  fn to_xdigit(x : Byte) {
    if x < 10 {
      x.to_int() + '0'.to_int() |> Char::from_int
    } else {
      x.to_int() - 10 + 'A'.to_int() |> Char::from_int
    }
  }

  fn aux(x : Byte) {
    if x < 0x0f {
      logger.write_char('0')
      logger.write_char(to_xdigit(x))
    } else {
      logger.write_char(to_xdigit(x >> 4))
      logger.write_char(to_xdigit(x & 0x0F))
    }
  }

  aux(self.red())
  aux(self.green())
  aux(self.blue())
  aux(self.alpha())
}

///|
pub fn Color::new(x : UInt) -> Color = "%identity"

///|
pub fn Color::to_hsl(self : Color) -> HSL {
  let r = self.red().to_int().to_double() / 255
  let g = self.green().to_int().to_double() / 255
  let b = self.blue().to_int().to_double() / 255
  let (h, s, l) = rgb_to_hsl(r, g, b)
  let hue = h.to_uint()
  let lightness = (l * 100).to_uint()
  let saturation = (s * 100).to_uint()
  { hue, saturation, lightness }
}
