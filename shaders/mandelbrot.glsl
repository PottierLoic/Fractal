#version 330 core

uniform vec2 resolution;
uniform float time;
uniform int maxIterations;

out vec4 FragColor;

void main() {
  vec2 uv = gl_FragCoord.xy / resolution.xy;

  vec2 mandelbrotCoord = vec2(uv.x * 3.5 - 2.5, uv.y * 2.0 - 1.0);

  vec2 z = mandelbrotCoord;
  int iterations = 0;

  while (iterations < maxIterations && length(z) < 4.0) {
      z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + mandelbrotCoord;
      iterations++;
  }

  float color = float(iterations) / float(maxIterations);
  FragColor = vec4(vec3(color), 1.0);
}