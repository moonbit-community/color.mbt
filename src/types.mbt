///|
/// RGBA color
struct Color(UInt32) derive(Default, Eq, Compare, Hash, Debug)

///|
/// HSL color
pub struct HSL {
  hue : UInt32
  saturation : UInt32
  lightness : UInt32
} derive(Default, Eq, Compare, Hash, Debug)

///|
pub impl Show for HSL with fn output(self, logger) {
  logger.write_string("{hue: ")
  logger.write_object(self.hue)
  logger.write_string(", saturation: ")
  logger.write_object(self.saturation)
  logger.write_string(", lightness: ")
  logger.write_object(self.lightness)
  logger.write_string("}")
}

///|
/// HSLA color
pub struct HSLA {
  hue : UInt32
  saturation : UInt32
  lightness : UInt32
  alpha : UInt32
} derive(Default, Eq, Compare, Hash, Debug)

///|
pub impl Show for HSLA with fn output(self, logger) {
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
