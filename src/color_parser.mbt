///|
fn is_hex(input : StringView) -> Bool {
  // Accept #rgb/#rgba/#rrggbb/#rrggbbaa, lowercase hex
  let regex = try! @string/regex.compile("^#([\\da-f]{3,4}|[\\da-f]{6,8})$")
  match regex.execute(input) {
    None => return false
    Some(_) => return true
  }
}

///|
/// Parse a CSS color string and return a fully-populated Colors object.
/// Currently supports hex: #rgb/#rgba/#rrggbb/#rrggbbaa
pub fn parse_color_string(color : String) -> Colors raise {
  // Handle hex forms first
  if is_hex(color) {
    // Normalize short hex (#rgb/#rgba) to long (#rrggbb[/aa])
    // Determine short vs long by total length:
    // #rgb => 4, #rgba => 5, #rrggbb => 7, #rrggbbaa => 9
    let len = color.length()
    let is_short = len == 4 || len == 5
    let (rr, gg, bb, aa_str) = if is_short {
      // #rgb or #rgba -> duplicate nibbles
      let r1 = color[1:2] catch { _ => "" }
      let g1 = color[2:3] catch { _ => "" }
      let b1 = color[3:4] catch { _ => "" }
      let a1 = color[4:5] catch { _ => "" }
      (
        "\{r1}\{r1}",
        "\{g1}\{g1}",
        "\{b1}\{b1}",
        if a1 == "" {
          ""
        } else {
          "\{a1}\{a1}"
        },
      )
    } else {
      // #rrggbb or #rrggbbaa -> wrap slices into Strings
      let rr_sv = color[1:3] catch { _ => "" }
      let gg_sv = color[3:5] catch { _ => "" }
      let bb_sv = color[5:7] catch { _ => "" }
      let aa_sv = color[7:9] catch { _ => "" }
      let rr = "\{rr_sv}"
      let gg = "\{gg_sv}"
      let bb = "\{bb_sv}"
      let aa = "\{aa_sv}"
      (rr, gg, bb, aa)
    }

    // Parse channels
    let r_u = try! @strconv.parse_uint(rr, base=16)
    let g_u = try! @strconv.parse_uint(gg, base=16)
    let b_u = try! @strconv.parse_uint(bb, base=16)
    let mut alpha_opt : Double? = None
    if aa_str != "" {
      let a_u = try! @strconv.parse_uint(aa_str, base=16)
      let a = a_u.to_double() / 255.0
      alpha_opt = Some(a)
    }

    // Compose normalized hex "#rrggbb"
    let hex = "#\{byte_to_hex2(r_u)}\{byte_to_hex2(g_u)}\{byte_to_hex2(b_u)}"

    // Build RGB
    let rgb = RGB::{
      r: r_u.to_double(),
      g: g_u.to_double(),
      b: b_u.to_double(),
      alpha: alpha_opt,
    }

    // Derive other spaces with propagated alpha
    let rh = rgb_to_hsl(rgb)
    let hsl = HSL::{ h: rh.h, s: rh.s, l: rh.l, alpha: alpha_opt }
    let rl = rgb_to_oklab(rgb)
    let oklab = LAB::{ l: rl.l, a: rl.a, b: rl.b, alpha: alpha_opt }
    let rc = rgb_to_oklch(rgb)
    let oklch = LCH::{ l: rc.l, c: rc.c, h: rc.h, alpha: alpha_opt }
    return Colors::{
      alpha: alpha_opt,
      hex,
      hsl,
      oklab,
      oklch,
      rgb,
      color_type: "hex",
    }
  }

  // Try rgb()/rgba()
  let rgb_re = try! @string/regex.compile(
    "^(?:rgba?|RGBA?)\\s*\\(\\s*([-+]?[\\d.]+)\\s*(?:[, ]+)\\s*([-+]?[\\d.]+)\\s*(?:[, ]+)\\s*([-+]?[\\d.]+)(?:\\s*(?:[,/])\\s*((?:[\\d.]+)%|[\\d.]+))?\\s*\\)\\s*$",
  )
  match rgb_re.execute(color) {
    Some(caps) => {
      let r_s = match caps.group(1) {
        Some(a) => a
        None => "0"
      }
      let g_s = match caps.group(2) {
        Some(a) => a
        None => "0"
      }
      let b_s = match caps.group(3) {
        Some(a) => a
        None => "0"
      }
      let a_s = match caps.group(4) {
        Some(a) => a
        None => ""
      }
      let r = try! @strconv.parse_double(r_s)
      let g = try! @strconv.parse_double(g_s)
      let b = try! @strconv.parse_double(b_s)
      // alpha parse: percent or number
      let mut alpha_opt : Double? = None
      if a_s != "" {
        let percent_re = try! @string/regex.compile("^([\\d.]+)%$")
        match percent_re.execute(a_s) {
          None => {
            let a = try! @strconv.parse_double(a_s)
            alpha_opt = Some(a)
          }
          Some(pcaps) => {
            let n = match pcaps.group(1) {
              Some(a) => a
              None => "0"
            }
            let a = try! (@strconv.parse_double(n) / 100.0)
            alpha_opt = Some(a)
          }
        }
      }
      let rgb = RGB::{ r, g, b, alpha: alpha_opt }
      let hex = rgb_to_hex(rgb)
      let rh = rgb_to_hsl(rgb)
      let hsl = HSL::{ h: rh.h, s: rh.s, l: rh.l, alpha: alpha_opt }
      let rl = rgb_to_oklab(rgb)
      let oklab = LAB::{ l: rl.l, a: rl.a, b: rl.b, alpha: alpha_opt }
      let rc = rgb_to_oklch(rgb)
      let oklch = LCH::{ l: rc.l, c: rc.c, h: rc.h, alpha: alpha_opt }
      return Colors::{
        alpha: alpha_opt,
        hex: "#\{hex}",
        hsl,
        oklab,
        oklch,
        rgb,
        color_type: "rgb",
      }
    }
    _ => ()
  }

  // Try hsl()/hsla(); s and l are percentages
  let hsl_re = try! @string/regex.compile(
    "^(?:hsla?|HSLA?)\\s*\\(\\s*([-+]?[\\d.]+)\\s*(?:[, ]+)\\s*([\\d.]+)%\\s*(?:[, ]+)\\s*([\\d.]+)%(?:\\s*(?:[,/])\\s*((?:[\\d.]+)%|[\\d.]+))?\\s*\\)\\s*$",
  )
  match hsl_re.execute(color) {
    Some(caps) => {
      let h_s = match caps.group(1) {
        Some(a) => a
        None => "0"
      }
      let s_s = match caps.group(2) {
        Some(a) => a
        None => "0"
      }
      let l_s = match caps.group(3) {
        Some(a) => a
        None => "0"
      }
      let a_s = match caps.group(4) {
        Some(a) => a
        None => ""
      }
      let h = try! @strconv.parse_double(h_s)
      let s = try! (@strconv.parse_double(s_s) / 100.0)
      let l = try! (@strconv.parse_double(l_s) / 100.0)
      let mut alpha_opt : Double? = None
      if a_s != "" {
        let percent_re = try! @string/regex.compile("^([\\d.]+)%$")
        match percent_re.execute(a_s) {
          None => {
            let a = try! @strconv.parse_double(a_s)
            alpha_opt = Some(a)
          }
          Some(pcaps) => {
            let n = match pcaps.group(1) {
              Some(a) => a
              None => "0"
            }
            let a = try! (@strconv.parse_double(n) / 100.0)
            alpha_opt = Some(a)
          }
        }
      }
      let hsl = HSL::{ h, s, l, alpha: alpha_opt }
      let rgb = hsl_to_rgb(hsl)
      let hex = rgb_to_hex(rgb)
      let rl = rgb_to_oklab(rgb)
      let oklab = LAB::{ l: rl.l, a: rl.a, b: rl.b, alpha: alpha_opt }
      let rc = rgb_to_oklch(rgb)
      let oklch = LCH::{ l: rc.l, c: rc.c, h: rc.h, alpha: alpha_opt }
      return Colors::{
        alpha: alpha_opt,
        hex: "#\{hex}",
        hsl,
        oklab,
        oklch,
        rgb,
        color_type: "hsl",
      }
    }
    _ => ()
  }

  // Try oklab(L% a b [ / alpha])
  let oklab_re = try! @string/regex.compile(
    "^(?:oklab)\\s*\\(\\s*([\\d.]+)%\\s+([-+]?[\\d.]+)\\s+([-+]?[\\d.]+)(?:\\s*/\\s*((?:[\\d.]+)%|[\\d.]+))?\\s*\\)\\s*$",
  )
  match oklab_re.execute(color) {
    Some(caps) => {
      let l_s = match caps.group(1) {
        Some(a) => a
        None => "0"
      }
      let a_s = match caps.group(2) {
        Some(a) => a
        None => "0"
      }
      let b_s = match caps.group(3) {
        Some(a) => a
        None => "0"
      }
      let al_s = match caps.group(4) {
        Some(a) => a
        None => ""
      }
      let l = try! (@strconv.parse_double(l_s) / 100.0)
      let a = try! @strconv.parse_double(a_s)
      let b = try! @strconv.parse_double(b_s)
      let mut alpha_opt : Double? = None
      if al_s != "" {
        let percent_re = try! @string/regex.compile("^([\\d.]+)%$")
        match percent_re.execute(al_s) {
          None => {
            let av = try! @strconv.parse_double(al_s)
            alpha_opt = Some(av)
          }
          Some(pcaps) => {
            let n = match pcaps.group(1) {
              Some(a) => a
              None => "0"
            }
            let av = try! (@strconv.parse_double(n) / 100.0)
            alpha_opt = Some(av)
          }
        }
      }
      let lab = LAB::{ l, a, b, alpha: alpha_opt }
      let rgb = oklab_to_rgb(lab)
      let hex = rgb_to_hex(rgb)
      let hsl = rgb_to_hsl(rgb)
      let lch = oklab_to_oklch(lab)
      let lch2 = LCH::{ l: lch.l, c: lch.c, h: lch.h, alpha: alpha_opt }
      return Colors::{
        alpha: alpha_opt,
        hex: "#\{hex}",
        hsl: HSL::{ h: hsl.h, s: hsl.s, l: hsl.l, alpha: alpha_opt },
        oklab: lab,
        oklch: lch2,
        rgb,
        color_type: "oklab",
      }
    }
    _ => ()
  }

  // Try oklch(L% c h [ / alpha])
  let oklch_re = try! @string/regex.compile(
    "^(?:oklch)\\s*\\(\\s*([\\d.]+)%\\s+([\\d.]+)\\s+([-+]?[\\d.]+)(?:\\s*/\\s*((?:[\\d.]+)%|[\\d.]+))?\\s*\\)\\s*$",
  )
  match oklch_re.execute(color) {
    Some(caps) => {
      let l_s = match caps.group(1) {
        Some(a) => a
        None => "0"
      }
      let c_s = match caps.group(2) {
        Some(a) => a
        None => "0"
      }
      let h_s = match caps.group(3) {
        Some(a) => a
        None => "0"
      }
      let al_s = match caps.group(4) {
        Some(a) => a
        None => ""
      }
      let l = try! (@strconv.parse_double(l_s) / 100.0)
      let c = try! @strconv.parse_double(c_s)
      let h = try! @strconv.parse_double(h_s)
      let mut alpha_opt : Double? = None
      if al_s != "" {
        let percent_re = try! @string/regex.compile("^([\\d.]+)%$")
        match percent_re.execute(al_s) {
          None => {
            let av = try! @strconv.parse_double(al_s)
            alpha_opt = Some(av)
          }
          Some(pcaps) => {
            let n = match pcaps.group(1) {
              Some(a) => a
              None => "0"
            }
            let av = try! (@strconv.parse_double(n) / 100.0)
            alpha_opt = Some(av)
          }
        }
      }
      let lch = LCH::{ l, c, h, alpha: alpha_opt }
      let lab = oklch_to_oklab(lch)
      let lab2 = LAB::{ l: lab.l, a: lab.a, b: lab.b, alpha: alpha_opt }
      let rgb = oklch_to_rgb(lch)
      let hex = rgb_to_hex(rgb)
      let hsl = rgb_to_hsl(rgb)
      return Colors::{
        alpha: alpha_opt,
        hex: "#\{hex}",
        hsl: HSL::{ h: hsl.h, s: hsl.s, l: hsl.l, alpha: alpha_opt },
        oklab: lab2,
        oklch: lch,
        rgb,
        color_type: "oklch",
      }
    }
    _ => ()
  }

  // For now, unsupported formats -> fallback: black
  let rgb = RGB::black()
  let hsl = rgb_to_hsl(rgb)
  let oklab = rgb_to_oklab(rgb)
  let oklch = rgb_to_oklch(rgb)
  Colors::{
    alpha: None,
    hex: "#000000",
    hsl,
    oklab,
    oklch,
    rgb,
    color_type: "hex",
  }
}
