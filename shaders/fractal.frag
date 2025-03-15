#version 330
out vec4 fragColor;
uniform vec2 center;
uniform float scale;
uniform vec2 resolution;
uniform int maxIterations;

vec3 palette(float t) {
  vec3 colors[4];
  colors[0] = vec3(0.0, 0.0, 0.0);
  colors[1] = vec3(0.0, 0.5, 1.0);
  colors[2] = vec3(1.0, 0.5, 0.0);
  colors[3] = vec3(1.0, 1.0, 1.0);

  float index = t * 3.0;
  int i = int(index);
  float frac = index - float(i);
  i = clamp(i, 0, 2);
  return mix(colors[i], colors[i + 1], frac);
}

void main() {
  vec2 aspect = vec2(resolution.x / resolution.y, 1.0);
  vec2 uv = ((gl_FragCoord.xy / resolution - 0.5) * aspect) * scale + center;
  vec2 z = vec2(0.0, 0.0);
  int i;
  for (i = 0; i < maxIterations; i++) {
    float x = z.x * z.x - z.y * z.y + uv.x;
    float y = 2.0 * z.x * z.y + uv.y;
    z = vec2(x, y);
    if (dot(z, z) > 4.0) break;
  }
  float t = float(i) / float(maxIterations);
  vec3 color = palette(t);
  fragColor = vec4(color, 1.0);
}