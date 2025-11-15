
///|
/// Construct an RGB from Double channels.
/// - r,g,b are Double in [0,255]
pub fn RGB::from_double(r : Double, g : Double, b : Double) -> RGB {
  RGB::{
    alpha: None,
    r: r,
    g: g,
    b: b,
  }
}

///|
/// Construct an RGB from a hex string.
/// - input format: "#RRGGBB"
pub fn RGB::from_hex(input : HEX) -> RGB raise {
  hex_to_rgb(input)
}
