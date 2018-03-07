module Colorable
  class Color
    def r
      self.rgb[0]
    end

    def g
      self.rgb[1]
    end

    def b
      self.rgb[2]
    end

    def brightness
      r + g + b
    end

    def blend(other, mode)
      case mode
      when :normal then other
      when :darker_color then self.brightness <= other.brightness ? self : other
      when :lighter_color then self.brightness >= other.brightness ? self : other
      else
        Formula.blend(mode, self, other)
      end
    end
  end

  class Formula
    class << self
      def calc(mode, raw_a, raw_b)
        a = [0.000001, raw_a / 255.0].max
        b = [0.000001, raw_b / 255.0].max

        c = case mode
            when :darken
              [a, b].min
            when :multiply
              a * b
            when :color_burn
              1 - (1 - a) / b
            when :linear_burn
              a + b - 1
            when :lighten
              [a, b].max
            when :screen
              1 - (1 - a) * (1 - b)
            when :color_dodge
              a / (1 - b)
            when :linear_dodge
              a + b
            when :overlay
              a < 0.5 ? 2 * a * b : 1 - 2 * (1 - a) * (1 - b)
            when :soft_light
              b < 0.5 ? 2 * a * b + a * a * (1 - 2 * b) : 2 * a * (1 - b) + a ** 0.5 * (2 * b - 1)
            when :hard_light
              calc(:overlay, raw_b, raw_a)
            when :vivid_light
              b > 0.5 ? 1 - (1 - a) / (2 * (b - 0.5)) : a / (1 - 2 * b)
            when :linear_light
              b > 0.5 ? a + 2 * (b - 0.5) : a + 2 * b - 1
            when :pin_light
              b > 0.5 ? [a, 2 * (b - 0.5)].max : [a, 2 * b].min
            when :difference
              (a - b).abs
            when :exclusion
              0.5 - 2 * (a - 0.5) * (b - 0.5)
            when :subtract
              [b - a, 0].max
            when :divide
              [b / a, 1].min
            when :hue
              raise 'not supported now'
            when :saturation
              raise 'not supported now'
            when :color
              raise 'not supported now'
            when :luminosity
              raise 'not supported now'
            else
              raise "Unknown mode specified=#{mode}"
            end
        
        c = (c * 255).round
        [[c, 0].max, 255].min
      end

      def blend(mode, top, bottom)
        r = Formula.calc(mode, top.r, bottom.r)
        g = Formula.calc(mode, top.g, bottom.g)
        b = Formula.calc(mode, top.b, bottom.b)
        Color.new [r, g, b]
      end
    end
  end
end