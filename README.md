# illusory0x0/color

A MoonBit color conversion and parsing library. It supports conversions among RGB/HSL/OKLab/OKLCh, CSS-like color string parsing/formatting, HEX helpers, and a set of predefined named colors.

## Install

Add the dependency to your `moon.mod.json` (use the latest version available):

```jsonc
{
  "dependencies": {
    "illusory0x0/color": "^0.2.3"
  }
}
```

## Quick start

```moonbit
// HSL <-> RGB
let hsl = HSL::{ h: 25.88, s: 1.0, l: 0.5, alpha: None }
let rgb = hsl_to_rgb(hsl)
let hsl2 = rgb_to_hsl(rgb)

// HEX <-> RGB
let rgb2 = hex_to_rgb("#ff0044")
let hex  = rgb_to_hex(rgb2) // "ff0044" (no leading #)

// OKLab / OKLCh interop
let lab = rgb_to_oklab(rgb)
let lch = oklab_to_oklch(lab)
let rgb3 = oklch_to_rgb(lch)

// Parse CSS-like color strings
let colors = parse_color_string("#ff6e00")
let s = colors.to_color_string()            // formatted by color_type
let s_with_alpha = colors.to_color_string_with_alpha()

// Packed integer RGBA (0xRRGGBBAA)
let c = RGB::from_rgba_u32(0xFF_6E_00_80U) // a = 0x80/255

// Predefined named colors (a few examples)
let red = RGB::red()
let rebeccapurple = RGB::rebeccapurple()
```

## Capabilities

- Core conversions
  - `hsl_to_rgb(hsl) -> RGB`
  - `rgb_to_hsl(rgb) -> HSL`
  - `rgb_to_oklab(rgb) -> LAB` / `oklab_to_rgb(lab) -> RGB`
  - `rgb_to_oklch(rgb) -> LCH` / `oklch_to_rgb(lch) -> RGB`
  - `oklab_to_oklch(lab) -> LCH` / `oklch_to_oklab(lch) -> LAB`
- HEX utilities
  - `hex_to_rgb("#rrggbb") -> RGB`
  - `rgb_to_hex(rgb) -> String` (returns `"rrggbb"`, without `#`)
  - `hsl_to_hex(hsl)` / `oklab_to_hex(lab)` / `oklch_to_hex(lch)`
- Parsing & formatting
  - Parse: `parse_color_string(String) -> Colors`, supports:
    - `#rgb`/`#rgba`/`#rrggbb`/`#rrggbbaa`
    - `rgb(...)`/`rgba(...)` (space or comma separators, alpha as number or percent)
    - `hsl(...)`/`hsla(...)` (s and l as percentages, alpha as number or percent)
    - `oklab(L% a b[/alpha])`, `oklch(L% c h[/alpha])`
  - Format:
    - `HSL::to_color_string(precision?)`
    - `RGB::to_color_string()`
    - `LAB::to_color_string(precision?)`
    - `LCH::to_color_string(precision?)`
    - `Colors::to_color_string(precision?)` (dispatches by `color_type`)
    - The corresponding `..._with_alpha` variants append `"/ alpha"` for non-hex types; hex returns `#RRGGBBAA`.
- Constructors & helpers
  - `RGB::from_double(r, g, b)` (Double channels in [0,255])
  - `RGB::from_hex("#rrggbb")`
  - `RGB::from_rgba_u32(0xRRGGBBAA)`
  - Many CSS named colors, e.g. `RGB::red()`, `RGB::rebeccapurple()`.

## Conventions & precision

- RGB channels `r/g/b` are Double with a semantic range of [0,255].
- HSL: `h` in degrees [0,360), `s/l` in [0,1].
- OKLab/OKLCh: `l` typically in [0,1]; `c >= 0`; `h` in degrees.
- The default formatting precision is controlled by `PRECISION = 5`. APIs round and clamp appropriately before output.
- Due to 8-bit quantization and round-trip conversions, small tolerances (especially for hue/saturation) are expected and normal.

## Examples: string formatting

```moonbit
let hsl = HSL::{ h: 49.73, s: 1.0, l: 0.7137, alpha: None }
hsl.to_color_string()                 // "hsl(49.73 100% 71.37%)"

let rgb = RGB::{ r: 255.0, g: 110.0, b: 0.0, alpha: Some(0.25) }
rgb.to_color_string_with_alpha()      // "rgb(255 110 0) / 0.25"

let lab = LAB::{ l: 0.70622, a: 0.1374, b: 0.14283, alpha: None }
lab.to_color_string()                 // "oklab(70.622% 0.1374 0.14283)"

let parsed = parse_color_string("#ff6e00")
parsed.to_color_string()              // "#ff6e00"
```

## License

Apache-2.0
