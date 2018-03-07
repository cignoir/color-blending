require 'colorable'
require './color.rb'

include Colorable

a = Color.new [25, 220, 140]
b = Color.new [244, 24, 24]

puts "normal: " + a.blend(b, :normal).to_s
puts "darken: " + a.blend(b, :darken).to_s
puts "multiply: " + a.blend(b, :multiply).to_s
puts "color_burn: " + a.blend(b, :color_burn).to_s
puts "linear_burn: " + a.blend(b, :linear_burn).to_s
puts "darker_color: " + a.blend(b, :darker_color).to_s
puts "lighten: " + a.blend(b, :lighten).to_s
puts "screen: " + a.blend(b, :screen).to_s
puts "color_dodge: " + a.blend(b, :color_dodge).to_s
puts "linear_dodge: " + a.blend(b, :linear_dodge).to_s
puts "lighter_color: " + a.blend(b, :lighter_color).to_s
puts "overlay: " + a.blend(b, :overlay).to_s
puts "soft_light: " + a.blend(b, :soft_light).to_s
puts "hard_light: " + a.blend(b, :hard_light).to_s
puts "vivid_light: " + a.blend(b, :vivid_light).to_s
puts "linear_light: " + a.blend(b, :linear_light).to_s
puts "pin_light: " + a.blend(b, :pin_light).to_s
puts "difference: " + a.blend(b, :difference).to_s
puts "exclusion: " + a.blend(b, :exclusion).to_s
puts "subtract: " + a.blend(b, :subtract).to_s
puts "divide: " + a.blend(b, :divide).to_s
