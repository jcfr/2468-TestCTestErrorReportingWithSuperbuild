
#include "A.h"

#include <iostream>

void A::whoami()
{
  std::cout << "I am A" << std::endl // Omit ";" to cause a build error
}

