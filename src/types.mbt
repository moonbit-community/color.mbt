///|
type HEX = String

///|
type ColorType = String

///|
/// HSLA color
pub struct HSL {
  h : Double
  s : Double
  l : Double
  alpha : Double?
} derive(Show, Default, Eq, Compare, Hash)

///|
pub struct LAB {
  alpha : Double?
  a : Double
  b : Double
  l : Double
} derive(Show, Default, Eq, Compare, Hash)

///|
pub struct LCH {
  alpha : Double?
  l : Double
  c : Double
  h : Double
} derive(Show, Default, Eq, Compare, Hash)

///|
pub struct RGB {
  alpha : Double?
  r : Double
  g : Double
  b : Double
} derive(Show, Default, Eq, Compare, Hash)

///|
pub struct Colors {
  alpha : Double?
  hex : HEX
  hsl : HSL
  oklab : LAB
  oklch : LCH
  rgb : RGB
  color_type : String
}
