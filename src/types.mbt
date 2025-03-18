///| RGBA color
type Color UInt derive(Default, Eq, Compare, Hash)

///| HSL color
pub struct HSL {
  hue : UInt
  saturation : UInt
  lightness : UInt
} derive(Show, Default, Eq, Compare, Hash)

///| HSLA color
pub struct HSLA {
  hue : UInt
  saturation : UInt
  lightness : UInt
  alpha : UInt
} derive(Show, Default, Eq, Compare, Hash)
