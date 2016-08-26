cmake_minimum_required(VERSION 2.8)
# About this project
#-------------------
project(src)

message("${PROJECT_NAME}")

# Add headers and source files here
#-------------------
cuda_add_executable(main main.cu)

# OpenCV
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

# CUDA
find_package(CUDA REQUIRED)
if(${CUDA_FOUND})
	message("Cuda found")
endif()

## Linker
##-------------------
target_link_libraries(main	${CUDA_LIBRARIES} ${OpenCV_LIBS})

