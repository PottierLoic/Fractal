#version 440
out vec4 fragColor;
uniform dvec2 center;
uniform double scale;
uniform vec2 resolution;
uniform int maxIterations;
uniform vec3 paletteColors[4];

vec3 palette(float t) {
  float scaledT = t * 4.0;
  int i = int(scaledT) % 4;
  float frac = scaledT - float(i);
  int nextI = (i + 1) % 4;
  return mix(paletteColors[i], paletteColors[nextI], frac);
}

void main() {
  dvec2 aspect = dvec2(resolution.x / resolution.y, 1.0);
  dvec2 uv = ((gl_FragCoord.xy / resolution - 0.5) * aspect) * scale + center;
  dvec2 z = dvec2(0.0, 0.0);
  int i;
  for (i = 0; i < maxIterations; i++) {
    double x = z.x * z.x - z.y * z.y + uv.x;
    double y = 2.0 * z.x * z.y + uv.y;
    z = dvec2(x, y);
    if (dot(z, z) > 4.0) break;
  }
  float t = float(i) / float(maxIterations);
  vec3 color = palette(t);
  fragColor = vec4(color, 1.0);
}