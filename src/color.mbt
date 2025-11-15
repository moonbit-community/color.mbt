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
/// Construct an RGB from a 32-bit packed RGBA integer 0xRRGGBBAA.
/// - Each byte is 8-bit sRGB; alpha byte AA will be normalized to [0,1].
/// - Example: 0xFF_FF_FF_00 => r=255, g=255, b=255, alpha=0.0 (fully transparent white)
pub fn RGB::from_rgba_u32(rgba : UInt) -> RGB {
  let r = ((rgba >> 24) & 0xFFU).to_double()
  let g = ((rgba >> 16) & 0xFFU).to_double()
  let b = ((rgba >> 8) & 0xFFU).to_double()
  let a = (rgba & 0xFFU).to_double() / 255.0
  RGB::{ r, g, b, alpha: Some(a) }
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
/// Helper: convert a byte [0,255] to two-digit lowercase hex string.
fn byte_to_hex2(u : UInt) -> String {
  let s = u.to_string(radix=16)
  if u < 16U { "0\{s}" } else { s }
}

///|
/// Helper: append/compose hex with alpha as #RRGGBBAA using the provided alpha [0,1].
fn hex_with_alpha(hex : StringView, alpha : Double) -> String {
  let a = clamp(alpha, min=0, max=1)
  let a_byte = @math.floor(a * 255.0).to_uint()
  let aa = byte_to_hex2(a_byte)
  // Compose #RRGGBBAA by appending AA to #RRGGBB
  "\{hex}\{aa}"
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
/// Convert HSL to CSS-like color string including alpha when present: "hsl(H S% L% / A)".
pub fn HSL::to_color_string_with_alpha(
  self : HSL,
  precision? : Int = PRECISION,
) -> String {
  let base = self.to_color_string(precision~)
  match self.alpha {
    None => base
    Some(a) => "\{base} / \{fixed_string(clamp(a, min=0, max=1), precision~)}"
  }
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
/// Convert RGB to CSS-like color string including alpha when present: "rgb(R G B / A)".
pub fn RGB::to_color_string_with_alpha(
  self : RGB,
  precision? : Int = PRECISION,
) -> String {
  let base = self.to_color_string()
  match self.alpha {
    None => base
    Some(a) => "\{base} / \{fixed_string(clamp(a, min=0, max=1), precision~)}"
  }
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
/// Convert Oklab to string including alpha when present: "oklab(L% a b / A)".
pub fn LAB::to_color_string_with_alpha(
  self : LAB,
  precision? : Int = PRECISION,
) -> String {
  let base = self.to_color_string(precision~)
  match self.alpha {
    None => base
    Some(a) => "\{base} / \{fixed_string(clamp(a, min=0, max=1), precision~)}"
  }
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
/// Convert Oklch to string including alpha when present: "oklch(L% c h / A)".
pub fn LCH::to_color_string_with_alpha(
  self : LCH,
  precision? : Int = PRECISION,
) -> String {
  let base = self.to_color_string(precision~)
  match self.alpha {
    None => base
    Some(a) => "\{base} / \{fixed_string(clamp(a, min=0, max=1), precision~)}"
  }
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

///|
/// Convert Colors to a string following color_type and append "/ alpha" when alpha exists.
/// Note: When color_type == "hex", alpha is not appended to hex string.
pub fn Colors::to_color_string_with_alpha(
  self : Colors,
  precision? : Int = PRECISION,
) -> String {
  let ty = self.color_type
  match ty {
    "hex" =>
      match self.alpha {
        None => self.hex
        Some(a) => hex_with_alpha(self.hex, a)
      }
    "rgb" => self.rgb.to_color_string_with_alpha(precision~)
    "hsl" => self.hsl.to_color_string_with_alpha(precision~)
    "oklab" => self.oklab.to_color_string_with_alpha(precision~)
    "oklch" => self.oklch.to_color_string_with_alpha(precision~)
    _ => self.hex
  }
}
