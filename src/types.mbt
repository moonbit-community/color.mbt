///| RGBA color
struct Color(UInt) derive(Default, Eq, Compare, Hash)

///| HSL color
pub struct HSL {
  hue : UInt
  saturation : UInt
  lightness : UInt
} derive(Default, Eq, Compare, Hash)

///|
pub impl Show for HSL with output(self, logger) {
  logger.write_string("{hue: ")
  logger.write_object(self.hue)
  logger.write_string(", saturation: ")
  logger.write_object(self.saturation)
  logger.write_string(", lightness: ")
  logger.write_object(self.lightness)
  logger.write_string("}")
}

///| HSLA color
pub struct HSLA {
  hue : UInt
  saturation : UInt
  lightness : UInt
  alpha : UInt
} derive(Default, Eq, Compare, Hash)

///|
pub impl Show for HSLA with output(self, logger) {
  logger.write_string("{hue: ")
  logger.write_object(self.hue)
  logger.write_string(", saturation: ")
  logger.write_object(self.saturation)
  logger.write_string(", lightness: ")
  logger.write_object(self.lightness)
  logger.write_string(", alpha: ")
  logger.write_object(self.alpha)
  logger.write_string("}")
}
