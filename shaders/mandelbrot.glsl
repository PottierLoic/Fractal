#version 400 core

uniform vec2 resolution;
uniform float time;
uniform int maxIterations;
uniform vec2 position;
uniform float zoom;

out vec4 FragColor;

void main() {
  dvec2 uv = gl_FragCoord.xy / resolution.xy;

  // more computation time caused by dvec2
  dvec2 mandelbrotCoord = (dvec2(uv) - 0.5) * dvec2(3.5 / zoom, 2.0 / zoom) + position;

  dvec2 z = mandelbrotCoord;
  int iterations = 0;

  while (iterations < maxIterations && length(z) < 4.0) {
    z = dvec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + mandelbrotCoord;
    iterations++;
  }

  float color = float(iterations) / float(maxIterations);
  FragColor = vec4(vec3(color), 1.0);
}
