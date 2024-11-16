project(cmake_example)

cmake_minimum_required(VERSION 3.30)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(verilator HINTS)

add_executable(Vour sim_main.cpp)

verilate(Vour SOURCES our.v)
