# Find Tomcrypt library
#
# Optional: TOMCRYPT_ROOT_DIR - where TOMCRYPT library is installed
#
# The following variables are set:
#  TOMCRYPT_FOUND
#  TOMCRYPT_INCLUDE_DIR
#  TOMCRYPT_LIBRARIES

find_path(TOMCRYPT_INCLUDE_DIR NAMES tomcrypt.h PATHS ${TOMCRYPT_ROOT_DIR} ../libtomcrypt ../../libtomcrypt PATH_SUFFIXES src/headers)

find_library(TOMCRYPT_LIBRARIES NAMES tomcrypt libtomcrypt PATHS ${TOMCRYPT_ROOT_DIR} ../libtomcrypt ../../libtomcrypt)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TOMCRYPT DEFAULT_MSG TOMCRYPT_INCLUDE_DIR TOMCRYPT_LIBRARIES)

if(TOMCRYPT_FOUND)
  message(STATUS "Found TOMCRYPT (include: ${TOMCRYPT_INCLUDE_DIR}, library: ${TOMCRYPT_LIBRARIES})")
  mark_as_advanced(TOMCRYPT_INCLUDE_DIR TOMCRYPT_LIBRARIES)
endif(TOMCRYPT_FOUND)

