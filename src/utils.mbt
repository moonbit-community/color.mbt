///|
fn assert_eq_with_error(
  x : Double,
  y : Double,
  error~ : Double,
  loc~ : SourceLoc = _
) -> Unit! {
  if (x - y).abs() > error {
    fail!("|\{x} - \{y}| <= \{error}", loc~)
  }
}
