///|
/// Construct an RGB from Double channels.
/// - r,g,b are Double in [0,255]
pub fn RGB::from_double(r : Double, g : Double, b : Double) -> RGB {
  RGB::{ alpha: None, r, g, b }
}

///|
/// Construct an RGB from a hex string.
/// - input format: "#RRGGBB"
pub fn RGB::from_hex(input : HEX) -> RGB raise {
  hex_to_rgb(input)
}

///|
/// Format helpers for color string outputs.
fn percent_string(value : Double, precision? : Int = PRECISION) -> String {
  // Round then rely on Double::to_string to trim unnecessary trailing zeros
  let v = round(value * 100.0, precision~)
  "\{v}%"
}

///|
fn fixed_string(value : Double, precision? : Int = PRECISION) -> String {
  // Round to desired precision; Double::to_string already trims, which is fine
  // Keep behavior consistent across a/b/c/h fields
  let v = round(value, precision~)
  v.to_string()
}

///|
/// Convert an HSL to CSS-like color string: "hsl(H S% L%)"
pub fn HSL::to_color_string(self : HSL, precision? : Int = PRECISION) -> String {
  let h_str = fixed_string(self.h, precision~)
  let s_str = percent_string(self.s, precision~)
  let l_str = percent_string(self.l, precision~)
  "hsl(\{h_str} \{s_str} \{l_str})"
}

///|
/// Convert an RGB to CSS-like color string: "rgb(R G B)" (8-bit integers)
pub fn RGB::to_color_string(self : RGB) -> String {
  let r = self.r.to_uint()
  let g = self.g.to_uint()
  let b = self.b.to_uint()
  "rgb(\{r} \{g} \{b})"
}

///|
/// Convert an Oklab to string: "oklab(L% a b)"
pub fn LAB::to_color_string(self : LAB, precision? : Int = PRECISION) -> String {
  let l_str = percent_string(self.l, precision~)
  let a_str = fixed_string(self.a, precision~)
  let b_str = fixed_string(self.b, precision~)
  "oklab(\{l_str} \{a_str} \{b_str})"
}

///|
/// Convert an Oklch to string: "oklch(L% c h)"
pub fn LCH::to_color_string(self : LCH, precision? : Int = PRECISION) -> String {
  let l_str = percent_string(self.l, precision~)
  let c_str = fixed_string(self.c, precision~)
  let h_str = fixed_string(self.h, precision~)
  "oklch(\{l_str} \{c_str} \{h_str})"
}

///|
/// Convert a Colors container to a string according to its color_type.
/// Supported types: "hex", "rgb", "hsl", "oklab", "oklch".
pub fn Colors::to_color_string(
  self : Colors,
  precision? : Int = PRECISION,
) -> String {
  let ty = self.color_type
  match ty {
    "hex" => self.hex
    "rgb" => self.rgb.to_color_string()
    "hsl" => self.hsl.to_color_string(precision~)
    "oklab" => self.oklab.to_color_string(precision~)
    "oklch" => self.oklch.to_color_string(precision~)
    _ => self.hex
  }
}
