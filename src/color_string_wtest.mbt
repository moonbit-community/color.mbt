///|
/// Tests for to_color_string implementations.

///|
test "HSL::to_color_string examples" {
  // brightPink
  let hsl1 = HSL::{ h: 344.0, s: 1.0, l: 0.5, alpha: None }
  assert_eq_str(hsl1.to_color_string(), "hsl(344 100% 50%)")

  // yellow
  let hsl2 = HSL::{ h: 49.73, s: 1.0, l: 0.7137, alpha: None }
  assert_eq_str(hsl2.to_color_string(), "hsl(49.73 100% 71.37%)")
}

///|
test "RGB/LAB/LCH::to_color_string examples" {
  // green
  let rgb = RGB::{ r: 0.0, g: 255.0, b: 68.0, alpha: None }
  assert_eq_str(rgb.to_color_string(), "rgb(0 255 68)")

  // violet (oklab)
  let lab = LAB::{ l: 0.47642, a: 0.02578, b: -0.29845, alpha: None }
  assert_eq_str(lab.to_color_string(), "oklab(47.642% 0.02578 -0.29845)")

  // orange (oklch)
  let lch = LCH::{ l: 0.70622, c: 0.19819, h: 46.11008, alpha: None }
  assert_eq_str(lch.to_color_string(), "oklch(70.622% 0.19819 46.11008)")
}

///|
test "to_color_string_with_alpha examples" {
  // RGB with alpha
  let rgb = RGB::{ r: 255.0, g: 0.0, b: 68.0, alpha: Some(0.5) }
  assert_eq_str(rgb.to_color_string_with_alpha(), "rgb(255 0 68) / 0.5")

  // HSL with alpha
  let hsl = HSL::{ h: 344.0, s: 1.0, l: 0.5, alpha: Some(0.33333) }
  assert_eq_str(hsl.to_color_string_with_alpha(), "hsl(344 100% 50%) / 0.33333")

  // OKLab with alpha
  let lab = LAB::{ l: 0.47642, a: 0.02578, b: -0.29845, alpha: Some(1.0) }
  assert_eq_str(lab.to_color_string_with_alpha(), "oklab(47.642% 0.02578 -0.29845) / 1")

  // OKLCh with alpha
  let lch = LCH::{ l: 0.70622, c: 0.19819, h: 46.11008, alpha: Some(0.0) }
  assert_eq_str(lch.to_color_string_with_alpha(), "oklch(70.622% 0.19819 46.11008) / 0")

  // Colors dispatch with alpha
  let c = Colors::{
    alpha: Some(0.25),
    hex: "#ff6e00",
    hsl: HSL::{ h: 25.88, s: 1.0, l: 0.5, alpha: Some(0.25) },
    oklab: LAB::{ l: 0.70622, a: 0.1374, b: 0.14283, alpha: Some(0.25) },
    oklch: LCH::{ l: 0.70622, c: 0.19819, h: 46.11008, alpha: Some(0.25) },
    rgb: RGB::{ r: 255.0, g: 110.0, b: 0.0, alpha: Some(0.25) },
    color_type: "rgb",
  }
  assert_eq_str(c.to_color_string_with_alpha(), "rgb(255 110 0) / 0.25")

  // Colors hex branch with alpha -> #RRGGBBAA
  let c_hex = Colors::{
    alpha: Some(0.5),
    hex: "#ff6e00",
    hsl: hsl,
    oklab: lab,
    oklch: lch,
    rgb: rgb,
    color_type: "hex",
  }
  assert_eq_str(c_hex.to_color_string_with_alpha(), "#ff6e007f")
}

///|
test "Colors::to_color_string dispatch" {
  // orange sample across all representations
  let hex = "#ff6e00"
  let hsl = HSL::{ h: 25.88, s: 1.0, l: 0.5, alpha: None }
  let oklab = LAB::{ l: 0.70622, a: 0.1374, b: 0.14283, alpha: None }
  let oklch = LCH::{ l: 0.70622, c: 0.19819, h: 46.11008, alpha: None }
  let rgb = RGB::{ r: 255.0, g: 110.0, b: 0.0, alpha: None }
  let c_hex = Colors::{
    alpha: None,
    hex,
    hsl,
    oklab,
    oklch,
    rgb,
    color_type: "hex",
  }
  let c_rgb = Colors::{
    alpha: None,
    hex,
    hsl,
    oklab,
    oklch,
    rgb,
    color_type: "rgb",
  }
  let c_hsl = Colors::{
    alpha: None,
    hex,
    hsl,
    oklab,
    oklch,
    rgb,
    color_type: "hsl",
  }
  let c_lab = Colors::{
    alpha: None,
    hex,
    hsl,
    oklab,
    oklch,
    rgb,
    color_type: "oklab",
  }
  let c_lch = Colors::{
    alpha: None,
    hex,
    hsl,
    oklab,
    oklch,
    rgb,
    color_type: "oklch",
  }
  assert_eq_str(c_hex.to_color_string(), "#ff6e00")
  assert_eq_str(c_rgb.to_color_string(), "rgb(255 110 0)")
  assert_eq_str(c_hsl.to_color_string(), "hsl(25.88 100% 50%)")
  assert_eq_str(c_lab.to_color_string(), "oklab(70.622% 0.1374 0.14283)")
  assert_eq_str(c_lch.to_color_string(), "oklch(70.622% 0.19819 46.11008)")
}
