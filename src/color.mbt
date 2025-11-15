///|
fn RGB::channel_from_double(x : Double) -> UInt {
  let clamped = if x < 0.0 { 0.0 } else if x > 1.0 { 1.0 } else { x }
  (clamped * 255.0 + 0.5).to_uint()
}

///|
pub fn RGB::from_double(r : Double, g : Double, b : Double) -> RGB {
  RGB::{
    alpha: None,
    r: RGB::channel_from_double(r),
    g: RGB::channel_from_double(g),
    b: RGB::channel_from_double(b),
  }
}

///|
pub fn RGB::from_hex(input : HEX) -> RGB raise {
  hex_to_rgb(input)
}
