#include <boost/python/numpy.hpp>
#include <iostream>

namespace p = boost::python;
namespace np = boost::python::numpy;

int main(int argc, char **argv)
{
  Py_Initialize();
  np::initialize();
}