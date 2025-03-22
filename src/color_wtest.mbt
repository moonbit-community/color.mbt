///|
test "output" {
  inspect!(Color::new(0x00_00_00_00), content="00000000")
  inspect!(Color::new(0xFF_00_00_00), content="FF000000")
  inspect!(Color::new(0xFF_FF_00_00), content="FFFF0000")
  inspect!(Color::new(0xFF_FF_FF_00), content="FFFFFF00")
}

///|
test "hsl/rgb" {
  let hsl_red = Color::hsl(0, 100, 50)
  let rgb_red = Color::rgb(255, 0, 0)
  assert_eq!(hsl_red, rgb_red)
  let hsl_blue = Color::hsl(240, 100, 50)
  let rgb_blue = Color::rgb(0, 0, 255)
  assert_eq!(hsl_blue, rgb_blue)
  let hsl_green = Color::hsl(120, 100, 50)
  let rgb_green = Color::rgb(0, 255, 0)
  assert_eq!(hsl_green, rgb_green)
  let hsl_white = Color::hsl(0, 0, 100)
  let rgb_white = Color::rgb(255, 255, 255)
  assert_eq!(hsl_white, rgb_white)
  let hsl_black = Color::hsl(0, 0, 0)
  let rgb_black = Color::rgb(0, 0, 0)
  assert_eq!(hsl_black, rgb_black)
  let hsl_purple = Color::hsl(300, 100, 25)
  let rgb_purple = Color::rgb(128, 0, 128)
  assert_eq!(hsl_purple, rgb_purple)
}

///|
test "to_hsl" {
  let red = Color::rgb(255, 0, 0)
  inspect!(red.to_hsl(), content="{hue: 0, saturation: 100, lightness: 50}")
  assert_eq!(red.to_hsl().to_color(), red)
  let green = Color::rgb(0, 255, 0)
  inspect!(green.to_hsl(), content="{hue: 120, saturation: 100, lightness: 50}")
  assert_eq!(green.to_hsl().to_color(), green)
  let blue = Color::rgb(0, 0, 255)
  inspect!(blue.to_hsl(), content="{hue: 240, saturation: 100, lightness: 50}")
  assert_eq!(blue.to_hsl().to_color(), blue)
  let white = Color::rgb(255, 255, 255)
  inspect!(white.to_hsl(), content="{hue: 0, saturation: 0, lightness: 100}")
  assert_eq!(white.to_hsl().to_color(), white)
  let black = Color::rgb(0, 0, 0)
  inspect!(black.to_hsl(), content="{hue: 0, saturation: 0, lightness: 0}")
  assert_eq!(black.to_hsl().to_color(), black)
  let color = Color::rgb(128, 0, 128)
  inspect!(color.to_hsl(), content="{hue: 300, saturation: 100, lightness: 25}")
  assert_eq!(color.to_hsl().to_color(), color)
}

///|
test "hsl/rgb convert error=5" {
  fn b2d(x : Byte) -> Double {
    x.to_int().to_double()
  }

  for h in 0U..<12 {
    for s = 4; s >= 1; s = s - 1 {
      for l = 8; l >= 0; l = l - 1 {
        let h = h * 30
        let s = (s.to_double() / 4 * 100).to_uint()
        let l = (l.to_double() / 8 * 100).to_uint()
        let actual = Color::hsl(h, s, l).to_hsl().to_color()
        let expected = HSL::new(h, s, l).to_color()
        let error : Double = 5
        assert_eq_with_error!(
          actual.red() |> b2d,
          expected.red() |> b2d,
          error~,
        )
        assert_eq_with_error!(
          actual.green() |> b2d,
          expected.green() |> b2d,
          error~,
        )
        assert_eq_with_error!(
          actual.blue() |> b2d,
          expected.blue() |> b2d,
          error~,
        )
      }
    }
  }
}

///|
test "hsl/rgb convert error=10" {
  fn b2d(x : Byte) -> Double {
    x.to_int().to_double()
  }

  for h in 0U..<360 {
    for s in 0U..=100 {
      for l in 0U..=100 {
        let actual = Color::hsl(h, s, l).to_hsl().to_color()
        let expected = HSL::new(h, s, l).to_color()
        let error : Double = 10
        assert_eq_with_error!(
          actual.red() |> b2d,
          expected.red() |> b2d,
          error~,
        )
        assert_eq_with_error!(
          actual.green() |> b2d,
          expected.green() |> b2d,
          error~,
        )
        assert_eq_with_error!(
          actual.blue() |> b2d,
          expected.blue() |> b2d,
          error~,
        )
      }
    }
  }
}
