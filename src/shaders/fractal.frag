#version 330
out vec4 fragColor;
uniform vec2 center;
uniform float scale;
uniform vec2 resolution;

void main() {
    vec2 aspect = vec2(resolution.x / resolution.y, 1.0);
    vec2 uv = ((gl_FragCoord.xy / resolution - 0.5) * aspect) * scale + center;
    vec2 z = vec2(0.0, 0.0);
    int i;
    for (i = 0; i < 100; i++) {
      float x = z.x * z.x - z.y * z.y + uv.x;
      float y = 2.0 * z.x * z.y + uv.y;
      z = vec2(x, y);
      if (dot(z, z) > 4.0) break;
    }
    float t = float(i) / 100.0;
    fragColor = vec4(t, t * t, sin(t), 1.0);
}