

#include "A.h"
#include "B.h"

// STD includes
#include <cstdlib>
#include <iostream>

int main(int argc, char* argv[])
{
  A a;
  a.whoami();
  B b;
  b.whoami();
  return EXIT_SUCCESS // Omit ";" to cause a build error
}

