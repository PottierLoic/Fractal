#version 440 core
out vec4 fragColor;
uniform dvec2 center;
uniform double scale;
uniform vec2 resolution;
uniform int maxIterations;
uniform vec3 paletteColors[4];
uniform dvec2 c;

vec3 palette(float t) {
  float scaledT = t * 3.0;
  int i = int(scaledT) % 4;
  float frac = scaledT - float(i);
  int nextI = (i + 1) % 4;
  return mix(paletteColors[i], paletteColors[nextI], frac);
}

void main() {
  dvec2 aspect = dvec2(resolution.x / resolution.y, 1.0);
  dvec2 z = ((dvec2(gl_FragCoord.xy) / dvec2(resolution) - 0.5) * aspect) * scale + center;
  int i;
  double magnitudeSquared;
  for (i = 0; i < maxIterations; i++) {
    double x = z.x * z.x - z.y * z.y + c.x;
    double y = 2.0 * z.x * z.y + c.y;
    z = dvec2(x, y);
    magnitudeSquared = dot(z, z);
    if (magnitudeSquared > 4.0) break;
  }
  float t;
  if (i == maxIterations) {
    t = 0.0;
  } else {
    float smoothValue = float(i) + 1.0 - log2(max(float(magnitudeSquared), 2.0)) / 2.0;
    t = 0.5 + 0.5 * sin(smoothValue / 50.0);
  }
  vec3 color = palette(t);
  fragColor = vec4(color, 1.0);
}