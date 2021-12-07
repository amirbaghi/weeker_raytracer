// std
#include <iostream>
#include <chrono>
// optix
#include <optix.h>
#include <optixu/optixpp.h>

// introOptix
#include "introOptix.h"

using namespace std::chrono;

int main(int argc, char *argv[])
{

  IntroOptix optixSingleton = IntroOptix();
  optixSingleton.init(1200, 600);
  auto start = high_resolution_clock::now();

  optixSingleton.createScene();
  auto stop = high_resolution_clock::now();
  optixSingleton.renderFrame();
  optixSingleton.printPPM();

  auto duration = duration_cast<milliseconds>(stop - start);
  // std::cout << duration.count() << std::endl;

  optixSingleton.destroy();
}
