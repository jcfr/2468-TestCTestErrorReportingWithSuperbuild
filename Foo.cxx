

#include "A1.h"
#include "A2.h"
#include "B.h"
#include "Bar.h"
#include "Iton.h"

// STD includes
#include <cstdlib>
#include <iostream>

int main(int argc, char* argv[])
{
  A1 a1;
  a1.whoami();
  A2 a2;
  a2.whoami();
  B b;
  b.whoami();
  Bar bar;
  bar.whoami();
  Iton iton;
  iton.whoami();
  return EXIT_SUCCESS // Omit ";" to cause a build error
}

