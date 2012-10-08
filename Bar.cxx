
#include "Bar.h"

#include <iostream>

void Bar::whoami()
{
  std::cout << "I am Bar" << std::endl // Omit ";" to cause a build error
}

