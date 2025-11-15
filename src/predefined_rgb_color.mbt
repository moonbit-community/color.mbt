///|
/// Common CSS named colors as convenience constructors on RGB.
/// Values are 8-bit sRGB components in the range [0,255].
/// Source: CSS Color Module Level 4 named colors.

// Basic colors
pub fn RGB::black() -> RGB {
  RGB::from_double(0.0, 0.0, 0.0)
}

///|
pub fn RGB::silver() -> RGB {
  RGB::from_double(192.0, 192.0, 192.0)
}

///|
pub fn RGB::gray() -> RGB {
  RGB::from_double(128.0, 128.0, 128.0)
}

///|
pub fn RGB::grey() -> RGB {
  RGB::from_double(128.0, 128.0, 128.0)
}

///|
pub fn RGB::white() -> RGB {
  RGB::from_double(255.0, 255.0, 255.0)
}

///|
pub fn RGB::maroon() -> RGB {
  RGB::from_double(128.0, 0.0, 0.0)
}

///|
pub fn RGB::red() -> RGB {
  RGB::from_double(255.0, 0.0, 0.0)
}

///|
pub fn RGB::purple() -> RGB {
  RGB::from_double(128.0, 0.0, 128.0)
}

///|
pub fn RGB::fuchsia() -> RGB {
  RGB::from_double(255.0, 0.0, 255.0)
}

///|
pub fn RGB::magenta() -> RGB {
  RGB::from_double(255.0, 0.0, 255.0)
}

///|
pub fn RGB::green() -> RGB {
  RGB::from_double(0.0, 128.0, 0.0)
}

///|
pub fn RGB::lime() -> RGB {
  RGB::from_double(0.0, 255.0, 0.0)
}

///|
pub fn RGB::olive() -> RGB {
  RGB::from_double(128.0, 128.0, 0.0)
}

///|
pub fn RGB::yellow() -> RGB {
  RGB::from_double(255.0, 255.0, 0.0)
}

///|
pub fn RGB::navy() -> RGB {
  RGB::from_double(0.0, 0.0, 128.0)
}

///|
pub fn RGB::blue() -> RGB {
  RGB::from_double(0.0, 0.0, 255.0)
}

///|
pub fn RGB::teal() -> RGB {
  RGB::from_double(0.0, 128.0, 128.0)
}

///|
pub fn RGB::aqua() -> RGB {
  RGB::from_double(0.0, 255.0, 255.0)
}

///|
pub fn RGB::cyan() -> RGB {
  RGB::from_double(0.0, 255.0, 255.0)
}

// Extended named colors

///|
pub fn RGB::aliceblue() -> RGB {
  RGB::from_double(240.0, 248.0, 255.0)
}

///|
pub fn RGB::antiquewhite() -> RGB {
  RGB::from_double(250.0, 235.0, 215.0)
}

///|
pub fn RGB::aquamarine() -> RGB {
  RGB::from_double(127.0, 255.0, 212.0)
}

///|
pub fn RGB::azure() -> RGB {
  RGB::from_double(240.0, 255.0, 255.0)
}

///|
pub fn RGB::beige() -> RGB {
  RGB::from_double(245.0, 245.0, 220.0)
}

///|
pub fn RGB::bisque() -> RGB {
  RGB::from_double(255.0, 228.0, 196.0)
}

///|
pub fn RGB::blanchedalmond() -> RGB {
  RGB::from_double(255.0, 235.0, 205.0)
}

///|
pub fn RGB::blueviolet() -> RGB {
  RGB::from_double(138.0, 43.0, 226.0)
}

///|
pub fn RGB::brown() -> RGB {
  RGB::from_double(165.0, 42.0, 42.0)
}

///|
pub fn RGB::burlywood() -> RGB {
  RGB::from_double(222.0, 184.0, 135.0)
}

///|
pub fn RGB::cadetblue() -> RGB {
  RGB::from_double(95.0, 158.0, 160.0)
}

///|
pub fn RGB::chartreuse() -> RGB {
  RGB::from_double(127.0, 255.0, 0.0)
}

///|
pub fn RGB::chocolate() -> RGB {
  RGB::from_double(210.0, 105.0, 30.0)
}

///|
pub fn RGB::coral() -> RGB {
  RGB::from_double(255.0, 127.0, 80.0)
}

///|
pub fn RGB::cornflowerblue() -> RGB {
  RGB::from_double(100.0, 149.0, 237.0)
}

///|
pub fn RGB::cornsilk() -> RGB {
  RGB::from_double(255.0, 248.0, 220.0)
}

///|
pub fn RGB::crimson() -> RGB {
  RGB::from_double(220.0, 20.0, 60.0)
}

///|
pub fn RGB::darkblue() -> RGB {
  RGB::from_double(0.0, 0.0, 139.0)
}

///|
pub fn RGB::darkcyan() -> RGB {
  RGB::from_double(0.0, 139.0, 139.0)
}

///|
pub fn RGB::darkgoldenrod() -> RGB {
  RGB::from_double(184.0, 134.0, 11.0)
}

///|
pub fn RGB::darkgray() -> RGB {
  RGB::from_double(169.0, 169.0, 169.0)
}

///|
pub fn RGB::darkgrey() -> RGB {
  RGB::from_double(169.0, 169.0, 169.0)
}

///|
pub fn RGB::darkgreen() -> RGB {
  RGB::from_double(0.0, 100.0, 0.0)
}

///|
pub fn RGB::darkkhaki() -> RGB {
  RGB::from_double(189.0, 183.0, 107.0)
}

///|
pub fn RGB::darkmagenta() -> RGB {
  RGB::from_double(139.0, 0.0, 139.0)
}

///|
pub fn RGB::darkolivegreen() -> RGB {
  RGB::from_double(85.0, 107.0, 47.0)
}

///|
pub fn RGB::darkorange() -> RGB {
  RGB::from_double(255.0, 140.0, 0.0)
}

///|
pub fn RGB::darkorchid() -> RGB {
  RGB::from_double(153.0, 50.0, 204.0)
}

///|
pub fn RGB::darkred() -> RGB {
  RGB::from_double(139.0, 0.0, 0.0)
}

///|
pub fn RGB::darksalmon() -> RGB {
  RGB::from_double(233.0, 150.0, 122.0)
}

///|
pub fn RGB::darkseagreen() -> RGB {
  RGB::from_double(143.0, 188.0, 143.0)
}

///|
pub fn RGB::darkslateblue() -> RGB {
  RGB::from_double(72.0, 61.0, 139.0)
}

///|
pub fn RGB::darkslategray() -> RGB {
  RGB::from_double(47.0, 79.0, 79.0)
}

///|
pub fn RGB::darkslategrey() -> RGB {
  RGB::from_double(47.0, 79.0, 79.0)
}

///|
pub fn RGB::darkturquoise() -> RGB {
  RGB::from_double(0.0, 206.0, 209.0)
}

///|
pub fn RGB::darkviolet() -> RGB {
  RGB::from_double(148.0, 0.0, 211.0)
}

///|
pub fn RGB::deeppink() -> RGB {
  RGB::from_double(255.0, 20.0, 147.0)
}

///|
pub fn RGB::deepskyblue() -> RGB {
  RGB::from_double(0.0, 191.0, 255.0)
}

///|
pub fn RGB::dimgray() -> RGB {
  RGB::from_double(105.0, 105.0, 105.0)
}

///|
pub fn RGB::dimgrey() -> RGB {
  RGB::from_double(105.0, 105.0, 105.0)
}

///|
pub fn RGB::dodgerblue() -> RGB {
  RGB::from_double(30.0, 144.0, 255.0)
}

///|
pub fn RGB::firebrick() -> RGB {
  RGB::from_double(178.0, 34.0, 34.0)
}

///|
pub fn RGB::floralwhite() -> RGB {
  RGB::from_double(255.0, 250.0, 240.0)
}

///|
pub fn RGB::forestgreen() -> RGB {
  RGB::from_double(34.0, 139.0, 34.0)
}

///|
pub fn RGB::gainsboro() -> RGB {
  RGB::from_double(220.0, 220.0, 220.0)
}

///|
pub fn RGB::ghostwhite() -> RGB {
  RGB::from_double(248.0, 248.0, 255.0)
}

///|
pub fn RGB::gold() -> RGB {
  RGB::from_double(255.0, 215.0, 0.0)
}

///|
pub fn RGB::goldenrod() -> RGB {
  RGB::from_double(218.0, 165.0, 32.0)
}

///|
pub fn RGB::greenyellow() -> RGB {
  RGB::from_double(173.0, 255.0, 47.0)
}

///|
pub fn RGB::honeydew() -> RGB {
  RGB::from_double(240.0, 255.0, 240.0)
}

///|
pub fn RGB::hotpink() -> RGB {
  RGB::from_double(255.0, 105.0, 180.0)
}

///|
pub fn RGB::indianred() -> RGB {
  RGB::from_double(205.0, 92.0, 92.0)
}

///|
pub fn RGB::indigo() -> RGB {
  RGB::from_double(75.0, 0.0, 130.0)
}

///|
pub fn RGB::ivory() -> RGB {
  RGB::from_double(255.0, 255.0, 240.0)
}

///|
pub fn RGB::khaki() -> RGB {
  RGB::from_double(240.0, 230.0, 140.0)
}

///|
pub fn RGB::lavender() -> RGB {
  RGB::from_double(230.0, 230.0, 250.0)
}

///|
pub fn RGB::lavenderblush() -> RGB {
  RGB::from_double(255.0, 240.0, 245.0)
}

///|
pub fn RGB::lawngreen() -> RGB {
  RGB::from_double(124.0, 252.0, 0.0)
}

///|
pub fn RGB::lemonchiffon() -> RGB {
  RGB::from_double(255.0, 250.0, 205.0)
}

///|
pub fn RGB::lightblue() -> RGB {
  RGB::from_double(173.0, 216.0, 230.0)
}

///|
pub fn RGB::lightcoral() -> RGB {
  RGB::from_double(240.0, 128.0, 128.0)
}

///|
pub fn RGB::lightcyan() -> RGB {
  RGB::from_double(224.0, 255.0, 255.0)
}

///|
pub fn RGB::lightgoldenrodyellow() -> RGB {
  RGB::from_double(250.0, 250.0, 210.0)
}

///|
pub fn RGB::lightgray() -> RGB {
  RGB::from_double(211.0, 211.0, 211.0)
}

///|
pub fn RGB::lightgrey() -> RGB {
  RGB::from_double(211.0, 211.0, 211.0)
}

///|
pub fn RGB::lightgreen() -> RGB {
  RGB::from_double(144.0, 238.0, 144.0)
}

///|
pub fn RGB::lightpink() -> RGB {
  RGB::from_double(255.0, 182.0, 193.0)
}

///|
pub fn RGB::lightsalmon() -> RGB {
  RGB::from_double(255.0, 160.0, 122.0)
}

///|
pub fn RGB::lightseagreen() -> RGB {
  RGB::from_double(32.0, 178.0, 170.0)
}

///|
pub fn RGB::lightskyblue() -> RGB {
  RGB::from_double(135.0, 206.0, 250.0)
}

///|
pub fn RGB::lightslategray() -> RGB {
  RGB::from_double(119.0, 136.0, 153.0)
}

///|
pub fn RGB::lightslategrey() -> RGB {
  RGB::from_double(119.0, 136.0, 153.0)
}

///|
pub fn RGB::lightsteelblue() -> RGB {
  RGB::from_double(176.0, 196.0, 222.0)
}

///|
pub fn RGB::lightyellow() -> RGB {
  RGB::from_double(255.0, 255.0, 224.0)
}

///|
pub fn RGB::limegreen() -> RGB {
  RGB::from_double(50.0, 205.0, 50.0)
}

///|
pub fn RGB::linen() -> RGB {
  RGB::from_double(250.0, 240.0, 230.0)
}

///|
pub fn RGB::mediumaquamarine() -> RGB {
  RGB::from_double(102.0, 205.0, 170.0)
}

///|
pub fn RGB::mediumblue() -> RGB {
  RGB::from_double(0.0, 0.0, 205.0)
}

///|
pub fn RGB::mediumorchid() -> RGB {
  RGB::from_double(186.0, 85.0, 211.0)
}

///|
pub fn RGB::mediumpurple() -> RGB {
  RGB::from_double(147.0, 112.0, 219.0)
}

///|
pub fn RGB::mediumseagreen() -> RGB {
  RGB::from_double(60.0, 179.0, 113.0)
}

///|
pub fn RGB::mediumslateblue() -> RGB {
  RGB::from_double(123.0, 104.0, 238.0)
}

///|
pub fn RGB::mediumspringgreen() -> RGB {
  RGB::from_double(0.0, 250.0, 154.0)
}

///|
pub fn RGB::mediumturquoise() -> RGB {
  RGB::from_double(72.0, 209.0, 204.0)
}

///|
pub fn RGB::mediumvioletred() -> RGB {
  RGB::from_double(199.0, 21.0, 133.0)
}

///|
pub fn RGB::midnightblue() -> RGB {
  RGB::from_double(25.0, 25.0, 112.0)
}

///|
pub fn RGB::mintcream() -> RGB {
  RGB::from_double(245.0, 255.0, 250.0)
}

///|
pub fn RGB::mistyrose() -> RGB {
  RGB::from_double(255.0, 228.0, 225.0)
}

///|
pub fn RGB::moccasin() -> RGB {
  RGB::from_double(255.0, 228.0, 181.0)
}

///|
pub fn RGB::navajowhite() -> RGB {
  RGB::from_double(255.0, 222.0, 173.0)
}

///|
pub fn RGB::oldlace() -> RGB {
  RGB::from_double(253.0, 245.0, 230.0)
}

///|
pub fn RGB::olivedrab() -> RGB {
  RGB::from_double(107.0, 142.0, 35.0)
}

///|
pub fn RGB::orange() -> RGB {
  RGB::from_double(255.0, 165.0, 0.0)
}

///|
pub fn RGB::orangered() -> RGB {
  RGB::from_double(255.0, 69.0, 0.0)
}

///|
pub fn RGB::orchid() -> RGB {
  RGB::from_double(218.0, 112.0, 214.0)
}

///|
pub fn RGB::palegoldenrod() -> RGB {
  RGB::from_double(238.0, 232.0, 170.0)
}

///|
pub fn RGB::palegreen() -> RGB {
  RGB::from_double(152.0, 251.0, 152.0)
}

///|
pub fn RGB::paleturquoise() -> RGB {
  RGB::from_double(175.0, 238.0, 238.0)
}

///|
pub fn RGB::palevioletred() -> RGB {
  RGB::from_double(219.0, 112.0, 147.0)
}

///|
pub fn RGB::papayawhip() -> RGB {
  RGB::from_double(255.0, 239.0, 213.0)
}

///|
pub fn RGB::peachpuff() -> RGB {
  RGB::from_double(255.0, 218.0, 185.0)
}

///|
pub fn RGB::peru() -> RGB {
  RGB::from_double(205.0, 133.0, 63.0)
}

///|
pub fn RGB::pink() -> RGB {
  RGB::from_double(255.0, 192.0, 203.0)
}

///|
pub fn RGB::plum() -> RGB {
  RGB::from_double(221.0, 160.0, 221.0)
}

///|
pub fn RGB::powderblue() -> RGB {
  RGB::from_double(176.0, 224.0, 230.0)
}

///|
pub fn RGB::rebeccapurple() -> RGB {
  RGB::from_double(102.0, 51.0, 153.0)
}

///|
pub fn RGB::rosybrown() -> RGB {
  RGB::from_double(188.0, 143.0, 143.0)
}

///|
pub fn RGB::royalblue() -> RGB {
  RGB::from_double(65.0, 105.0, 225.0)
}

///|
pub fn RGB::saddlebrown() -> RGB {
  RGB::from_double(139.0, 69.0, 19.0)
}

///|
pub fn RGB::salmon() -> RGB {
  RGB::from_double(250.0, 128.0, 114.0)
}

///|
pub fn RGB::sandybrown() -> RGB {
  RGB::from_double(244.0, 164.0, 96.0)
}

///|
pub fn RGB::seagreen() -> RGB {
  RGB::from_double(46.0, 139.0, 87.0)
}

///|
pub fn RGB::seashell() -> RGB {
  RGB::from_double(255.0, 245.0, 238.0)
}

///|
pub fn RGB::sienna() -> RGB {
  RGB::from_double(160.0, 82.0, 45.0)
}

///|
pub fn RGB::skyblue() -> RGB {
  RGB::from_double(135.0, 206.0, 235.0)
}

///|
pub fn RGB::slateblue() -> RGB {
  RGB::from_double(106.0, 90.0, 205.0)
}

///|
pub fn RGB::slategray() -> RGB {
  RGB::from_double(112.0, 128.0, 144.0)
}

///|
pub fn RGB::slategrey() -> RGB {
  RGB::from_double(112.0, 128.0, 144.0)
}

///|
pub fn RGB::snow() -> RGB {
  RGB::from_double(255.0, 250.0, 250.0)
}

///|
pub fn RGB::springgreen() -> RGB {
  RGB::from_double(0.0, 255.0, 127.0)
}

///|
pub fn RGB::steelblue() -> RGB {
  RGB::from_double(70.0, 130.0, 180.0)
}

///|
pub fn RGB::tan() -> RGB {
  RGB::from_double(210.0, 180.0, 140.0)
}

///|
pub fn RGB::thistle() -> RGB {
  RGB::from_double(216.0, 191.0, 216.0)
}

///|
pub fn RGB::tomato() -> RGB {
  RGB::from_double(255.0, 99.0, 71.0)
}

///|
pub fn RGB::turquoise() -> RGB {
  RGB::from_double(64.0, 224.0, 208.0)
}

///|
pub fn RGB::violet() -> RGB {
  RGB::from_double(238.0, 130.0, 238.0)
}

///|
pub fn RGB::wheat() -> RGB {
  RGB::from_double(245.0, 222.0, 179.0)
}

///|
pub fn RGB::whitesmoke() -> RGB {
  RGB::from_double(245.0, 245.0, 245.0)
}

///|
pub fn RGB::yellowgreen() -> RGB {
  RGB::from_double(154.0, 205.0, 50.0)
}
