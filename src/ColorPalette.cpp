#include "ColorPalette.hpp"

ColorPalette::ColorPalette(const std::vector<sf::Color>& colors) : colors(colors) {}

sf::Color ColorPalette::getColor(float position) const {
  // Calculate the index of the first color
  float indexFloat = position * (colors.size() - 1);
  int index = static_cast<int>(indexFloat);

  // Calculate the interpolation factor
  float t = indexFloat - static_cast<float>(index);

  // Interpolate between the two closest colors
  return interpolateColors(colors[index], colors[index + 1], t);
}

int ColorPalette::colorCount() const {
  return colors.size();
}

sf::Color ColorPalette::interpolateColors(const sf::Color& color1, const sf::Color& color2, float t) const {
  // Perform linear interpolation between two colors
  sf::Uint8 r = static_cast<sf::Uint8>((1 - t) * color1.r + t * color2.r);
  sf::Uint8 g = static_cast<sf::Uint8>((1 - t) * color1.g + t * color2.g);
  sf::Uint8 b = static_cast<sf::Uint8>((1 - t) * color1.b + t * color2.b);
  sf::Uint8 a = static_cast<sf::Uint8>((1 - t) * color1.a + t * color2.a);

  return sf::Color(r, g, b, a);
}