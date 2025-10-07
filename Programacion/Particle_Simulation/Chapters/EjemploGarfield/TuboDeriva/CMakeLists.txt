cmake_minimum_required(VERSION 3.16)
project(Test_Garfield_ROOT_Geant4 CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --- ROOT ---
find_package(ROOT REQUIRED COMPONENTS Core RIO Hist Graf Gpad Tree)
include_directories(${ROOT_INCLUDE_DIRS})
add_definitions(${ROOT_CXX_FLAGS})

# --- Geant4 ---
find_package(Geant4 REQUIRED)
include(${Geant4_USE_FILE})

# --- Garfield++ ---
# Primero intenta vía config
set(GARFIELD_HINT /home/daniel/garfield/install)
find_package(Garfield REQUIRED
  PATHS ${GARFIELD_HINT}/lib/cmake/Garfield
  NO_DEFAULT_PATH
)

# Incluye headers de Garfield (por si el config no exporta bien)
include_directories(${Garfield_INCLUDE_DIRS})
include_directories(/home/daniel/garfield/install/include)

# Fallbacks: localizar libs por si el config no las da completas
find_library(GARFIELD_LIB       NAMES Garfield       HINTS ${GARFIELD_HINT}/lib)
find_library(MAGBOLTZ_LIB       NAMES Magboltz       HINTS ${GARFIELD_HINT}/lib)
find_library(HEED_LIB           NAMES Heed           HINTS ${GARFIELD_HINT}/lib)
find_library(GARFIELD_RANDOM_LIB NAMES GarfieldRandom HINTS ${GARFIELD_HINT}/lib)
find_library(DEGRADE_LIB        NAMES Degrade        HINTS ${GARFIELD_HINT}/lib)

# Ejecutable
add_executable(test main.cpp)

# Enlazado principal
target_link_libraries(test
  ${ROOT_LIBRARIES}
  ${Geant4_LIBRARIES}
  ${Garfield_LIBRARIES}        # si el config está bien, esto basta
  ${GARFIELD_LIB}
  ${MAGBOLTZ_LIB}
  ${HEED_LIB}
  ${GARFIELD_RANDOM_LIB}
  ${DEGRADE_LIB}
)

# rpath para no depender de LD_LIBRARY_PATH
# (ajusta la ruta si instalaste Garfield en otro sitio)
set_target_properties(test PROPERTIES
  BUILD_RPATH "/home/daniel/garfield/install/lib"
  INSTALL_RPATH "/home/daniel/garfield/install/lib"
)
