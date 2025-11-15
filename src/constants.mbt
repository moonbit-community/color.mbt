///|
const DEG2RAD : Double = @math.PI / 180

///|
const RAD2DEG : Double = 180.0 / @math.PI

///|
const PRECISION : Int = 5

///|
priv struct Vec2(Double, Double)

///|
priv struct Vec3(Double, Double, Double)

///|
priv struct LabToLms {
  l : Vec2
  m : Vec2
  s : Vec2
}

///|
let lab_to_lms : LabToLms = LabToLms::{
  l: Vec2(0.3963377773761749, 0.2158037573099136),
  m: Vec2(-0.1055613458156586, -0.0638541728258133),
  s: Vec2(-0.0894841775298119, -1.2914855480194092),
}

///|
priv struct LrgbToLms {
  l : Vec3
  m : Vec3
  s : Vec3
}

///|
let lrgb_to_lms : LrgbToLms = LrgbToLms::{
  l: Vec3(0.4122214708, 0.5363325363, 0.0514459929),
  m: Vec3(0.2119034982, 0.6806995451, 0.1073969566),
  s: Vec3(0.0883024619, 0.2817188376, 0.6299787005),
}

///|
priv struct LsmToLab {
  l : Vec3
  a : Vec3
  b : Vec3
}

///|
let lsm_to_lab : LsmToLab = LsmToLab::{
  l: Vec3(0.2104542553, 0.793617785, 0.0040720468),
  a: Vec3(1.9779984951, 2.428592205, 0.4505937099),
  b: Vec3(0.0259040371, 0.7827717662, 0.808675766),
}

///|
priv struct LsmToRgb {
  r : Vec3
  g : Vec3
  b : Vec3
}

///|
let lsm_to_rgb : LsmToRgb = LsmToRgb::{
  r: Vec3(4.0767416360759583, -3.3077115392580629, 0.2309699031821043),
  g: Vec3(-1.2684379732850315, 2.6097573492876882, -0.341319376002657),
  b: Vec3(-0.0041960761386756, -0.7034186179359362, 1.7076146940746117),
}

///|
priv struct Mat3x3(Vec3, Vec3, Vec3)

///|
let srgb_to_p3 : Mat3x3 = Mat3x3(
  Vec3(0.8224270476, 0.1775729524, 0.0),
  Vec3(0.0331008087, 0.9668991913, 0.0),
  Vec3(0.0170720188, 0.0723477973, 0.9105801839),
)
