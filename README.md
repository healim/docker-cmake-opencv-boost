# CMake, Boost and OpenCV on Python 3.5.3

This docker image was built with CMake, Boost C++ Library and OpenCV 3.2.0 installed onto the official python:3.5.3 docker image.

## Usage in Dockerfile

With your own Dockerfile

```dockerfile
FROM pathtrk/cmake-opencv-boost
```

## Using Boost and OpenCV

Your C++ code can find them with instructions in CMakeList.txt as below 

```cmake
find_package(OpenCV 3.2 REQUIRED)
```

OR

```cmake
find_package(Boost COMPONENTS filesystem system program_options REQUIRED)
```

## Test run with this Dockerfile

The test C++ file can be compiled like following,

```bash
$ docker buiild -t boost-opencv .
$ docker run -it -v `pwd`:/home/docker/code boost-opencv /bin/bash
> cd /home/docker/code
> g++ test_boost_numpy.cc -I /usr/local/include/python3.5m \
    -lboost_python3 -lboost_numpy3 -lpython3.5m
```

It just works, but the compiled binary does nothing by default.
