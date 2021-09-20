# Find DES library
#
# Optional: DES_ROOT_DIR - where DES library is installed
#
# The following variables are set:
#  DES_FOUND
#  DES_INCLUDE_DIR
#  DES_LIBRARIES

find_path(DES_INCLUDE_DIR NAMES des.h PATHS ${DES_ROOT_DIR} ../libdes ../../libdes)

find_library(DES_LIBRARIES NAMES des libdes PATHS ${DES_ROOT_DIR} ../libdes ../../libdes)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DES DEFAULT_MSG DES_INCLUDE_DIR DES_LIBRARIES)

if(DES_FOUND)
  message(STATUS "Found DES (include: ${DES_INCLUDE_DIR}, library: ${DES_LIBRARIES})")
  mark_as_advanced(DES_INCLUDE_DIR DES_LIBRARIES)
endif(DES_FOUND)

