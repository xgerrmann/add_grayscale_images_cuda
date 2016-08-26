cmake_minimum_required(VERSION 2.8.4)

# About this project
#-------------------
project(add_grayscale_images_cuda)

# Set env
#-------------------

message("Binary Tree path: ${PROJECT_BINARY_DIR}")

## Add subfolders
#-------------------
add_subdirectory(src)
#add_subdirectory(include)
#add_subdirectory(lib)
