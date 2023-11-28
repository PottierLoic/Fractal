#pragma once

#include <vector>
#include <string>

#include <SFML/Graphics/Color.hpp>

class ColorPalette {
public:
  std::vector<sf::Color> colors;

  // Initialize a palette with a list of colors.
  ColorPalette(const std::vector<sf::Color>& colors);
  // Get the interpolated color at a specific position [0, 1].
  sf::Color getColor(float position) const;
  // Get the number of colors in the palette.
  int colorCount() const;
  // Interpolate between two colors.
  sf::Color interpolateColors(const sf::Color& color1, const sf::Color& color2, float t) const;
};

/* Color palettes */
const ColorPalette PALETTE_BLACK_WHITE({
  sf::Color::Black,
  sf::Color::White
});

const ColorPalette PALETTE_VOLCANO({
  sf::Color::Yellow,
  sf::Color::Red
});

/* Color palettes list */
const std::vector<ColorPalette> PALETTES = {
  PALETTE_BLACK_WHITE,
  PALETTE_VOLCANO
};

const std::vector<const char*> PALETTE_NAMES = {
  "Black and white",
  "Volcano"
};