#include "FractalSimulator.hpp"
#include <iostream>

int main() {
  try {
    FractalSimulator simulator(800, 600, "Fractal Simulator");
    simulator.run();
  } catch (const std::exception& e) {
    std::cerr << e.what() << std::endl;
    return -1;
  }
  return 0;
}