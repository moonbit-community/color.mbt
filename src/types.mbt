///|
/// Hex color string type alias.
/// - Expected format: "#RRGGBB" (lowercase/uppercase both accepted)
type HEX = String

///|
/// A descriptive color type label, e.g. "hex", "rgb", "hsl", "oklab", "oklch".
type ColorType = String

///|
/// HSL(A) color with Double components.
/// - h in degrees [0,360)
/// - s,l in [0,1]
/// - alpha optional in [0,1]
pub struct HSL {
  h : Double
  s : Double
  l : Double
  alpha : Double?
} derive(Show, Default, Eq, Compare, Hash)

///|
/// Oklab color with optional alpha.
pub struct LAB {
  alpha : Double?
  a : Double
  b : Double
  l : Double
} derive(Show, Default, Eq, Compare, Hash)

///|
/// Oklch color with optional alpha.
/// - l in [0,1] typically, c >= 0, h in degrees
pub struct LCH {
  alpha : Double?
  l : Double
  c : Double
  h : Double
} derive(Show, Default, Eq, Compare, Hash)

///|
/// RGB color with Double channels and optional alpha.
/// - r,g,b in [0,255]
pub struct RGB {
  alpha : Double?
  r : Double
  g : Double
  b : Double
} derive(Show, Default, Eq, Compare, Hash)

///|
/// Container for multiple color space representations.
pub struct Colors {
  alpha : Double?
  hex : HEX
  hsl : HSL
  oklab : LAB
  oklch : LCH
  rgb : RGB
  color_type : String
}
