#include "FractalSimulator.hpp"

int main() {
  try {
    FractalSimulator simulator(800, 600, "Fractal Simulator");
    simulator.run();
  } catch (const std::exception& e) {
    std::cerr << "Error: " << e.what() << std::endl;
    return 1;
  }
  return 0;
}