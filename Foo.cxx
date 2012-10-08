

#include "A.h"
#include "B.h"
#include "Bar.h"
#include "Iton.h"

// STD includes
#include <cstdlib>
#include <iostream>

int main(int argc, char* argv[])
{
  A a;
  a.whoami();
  B b;
  b.whoami();
  Bar bar;
  bar.whoami();
  Iton iton;
  iton.whoami();
  return EXIT_SUCCESS // Omit ";" to cause a build error
}

