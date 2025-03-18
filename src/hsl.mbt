///|
pub fn HSL::to_color(self : HSL) -> Color {
  try {
    Color::hsl!(self.hue, self.saturation, self.lightness)
  } catch {
    _ => abort("unreachable")
  }
}

///|
pub fn HSL::new(hue : UInt, saturation : UInt, lightness : UInt) -> HSL! {
  validate_hsla!(hue, saturation, lightness, 100)
  { hue, saturation, lightness }
}

///|
pub fn HSL::to_hsla(self : HSL) -> HSLA {
  {
    hue: self.hue,
    saturation: self.saturation,
    lightness: self.lightness,
    alpha: 100,
  }
}
