///|
fn is_hex(input : StringView) -> Bool {
  let regex = try! @string/regex.compile("^#([\\da-f]{3,4}|[\\da-f]{6,8})$")
  match regex.execute(input) {
    None => return false
    Some(_) => return true
  }
}

///|
pub fn parse_color_string(color : String) -> Unit {
  if is_hex(color) {
    let alpha = color[7:9] catch { _ => "ff" }
    let alpha = try! @strconv.parse_uint(alpha, base=16)

  }
  let regex = try! @string/regex.compile(
    "(?:(rgb|hsl|oklab|oklch)a?\\s*\\(\\s*([\\d%.-]+)\\s*[ ,/]\\s*([\\d%.-]+)\\s*[ ,/]\\s*([\\d%.-]+)(?:\\s*[ ,/]\\s*([\\d%.-]+))?\\s*\\))",
  )

}
