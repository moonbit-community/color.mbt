///|
#callsite(autofill(loc))
fn assert_eq_with_error(
  x : Double,
  y : Double,
  error~ : Double,
  loc~ : SourceLoc,
) -> Unit raise {
  if (x - y).abs() > error {
    fail("|\{x} - \{y}| <= \{error}", loc~)
  }
}
