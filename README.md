# CMake, Boost and OpenCV on Python 3.5.3

This docker image was built with CMake, Boost C++ Library and OpenCV 3.2.0 installed onto the official python:3.5.3 docker image.


## Usage in Dockerfile

With your own Dockerfile
```
from pathtrk/cmake-opencv-boost
```


## Using Boost and OpenCV

Your C++ code can find them with instructions in CMakeList.txt as below 

```
find_package(OpenCV 3.2 REQUIRED)
```

OR

```
find_package(Boost COMPONENTS filesystem system program_options REQUIRED)
```
