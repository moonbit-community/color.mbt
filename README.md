# illusory0x0/color

# Usage

use `hsl_to_rgb` and `rgb_to_hsl` to convert color. 

use `Color` to store RGBA color (32 bits), 
It is not recommended use `to_hsl` to convert RGB to HSL and then use `to_color` to convert HSL to RGB, it will lose precision due to truncation.