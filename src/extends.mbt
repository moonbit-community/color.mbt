///|
pub extend Color with Show::{to_string, output}

///|
pub extend Color with Default::{default}

///|
pub extend Color with Eq::{not_equal, equal}

///|
pub extend Color with Compare::{op_lt, op_le, op_ge, compare, op_gt}

///|
pub extend Color with Hash::{hash, hash_combine}

///|
pub extend HSL with Default::{default}

///|
pub extend HSL with Eq::{not_equal, equal}

///|
pub extend HSL with Compare::{op_lt, op_le, op_ge, compare, op_gt}

///|
pub extend HSL with Hash::{hash, hash_combine}

///|
pub extend HSL with Show::{to_string, output}

///|
pub extend HSLA with Default::{default}

///|
pub extend HSLA with Eq::{not_equal, equal}

///|
pub extend HSLA with Compare::{op_lt, op_le, op_ge, compare, op_gt}

///|
pub extend HSLA with Hash::{hash, hash_combine}

///|
pub extend HSLA with Show::{to_string, output}

///|
pub extend Color with @debug.Debug::{to_repr}

///|
pub extend HSL with @debug.Debug::{to_repr}

///|
pub extend HSLA with @debug.Debug::{to_repr}
