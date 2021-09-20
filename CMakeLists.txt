message (STATUS "Running with CMake ${CMAKE_VERSION}")
cmake_minimum_required (VERSION 3.15)

project (snmp_pp VERSION 3.4.7 LANGUAGES CXX)
enable_language (CXX)

include (CheckIncludeFiles)
include (CheckFunctionExists)
include (CheckSymbolExists)
include (CheckLibraryExists)
include (CheckStructHasMember)
include (CheckTypeSize)

set (CMAKE_CXX_STANDARD 14)

list (APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/modules)


option (OPTION_SNMPv3  "Enable support for SNMPv3" ON)
option (OPTION_IPv6    "Enable support for IPv6" ON)
option (OPTION_THREADS "Enable support for threads" ON)
option (OPTION_NAMESPACE "Enable using of namespace" ON)
option (OPTION_LOGGING "Enable logging" ON)
option (OPTION_MACADDR "Enable MacAddress class" OFF)
option (OPTION_IPXADDR "Enable IpxAddress class" OFF)
option (OPTION_OPENSSL "Search for OpenSSL library" ON)
option (OPTION_LIBDES "Search for DES library" OFF)
option (OPTION_LIBTOMCRYPT "Search for Tomcrypt library" OFF)
option (OPTION_EXTENDED_DEBUG "Enable additional debug messages" OFF)

set (LogProfile "original" CACHE STRING
  "Log Profile")

set (LogProfileValues "original;off;quiet;std;events;verbose;full;debug;schwafel" CACHE STRING
  "List of possible values for the Log Profile variable")

set_property (CACHE LogProfile PROPERTY STRINGS ${LogProfileValues})

message (STATUS "LogProfile='${LogProfile}'")

set (VERSION ${PROJECT_VERSION})
set (SNMP_PP_MAJOR_VERSION ${PROJECT_VERSION_MAJOR})
set (SNMP_PP_MINOR_VERSION ${PROJECT_VERSION_MINOR})
set (SNMP_PP_MICRO_VERSION ${PROJECT_VERSION_PATCH})

message (STATUS "snmp++ Version ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")

check_include_files (sys/types.h CNF_HAVE_SYS_TYPES_H)
check_include_files (sys/stat.h CNF_HAVE_SYS_STAT_H)
check_include_files ("cctype;cerrno;climits;csignal;cstddef;cstdio;cstdlib;cstring;ctime" CNF_STDCXX_98_HEADERS)
check_include_files ("iostream" CNF_HAVE_IOSTREAM)
check_include_files ("stdlib.h;stddef.h" CNF_STDC_HEADERS)
check_include_files (stdlib.h CNF_HAVE_STDLIB_H)
check_include_files (string.h CNF_HAVE_STRING_H)
check_include_files (memory.h CNF_HAVE_MEMORY_H)
check_include_files (strings.h CNF_HAVE_STRINGS_H)
check_include_files (inttypes.h CNF_HAVE_INTTYPES_H)
check_include_files (ctype.h CNF_HAVE_CTYPE_H)
check_include_files (signal.h CNF_HAVE_SIGNAL_H)
check_include_files (errno.h CNF_HAVE_ERRNO_H)
check_include_files (time.h CNF_HAVE_TIME_H)
check_include_files (unistd.h CNF_HAVE_UNISTD_H)
check_include_files (sys/unistd.h CNF_HAVE_SYS_UNISTD_H)
check_include_files (stdint.h CNF_HAVE_STDINT_H)
check_include_files (sys/time.h CNF_HAVE_SYS_TIME_H)
check_include_files (sys/param.h CNF_HAVE_SYS_PARAM_H)
check_include_files (sys/timeb.h CNF_HAVE_SYS_TIMEB_H)
check_include_files (winsock2.h CNF_HAVE_WINSOCK2_H)
check_include_files (ws2tcpip.h CNF_HAVE_WS2TCPIP_H)
check_include_files (wspiapi.h CNF_HAVE_WSPIAPI_H)
check_include_files (winsock.h CNF_HAVE_WINSOCK_H)
check_include_files (netdb.h CNF_HAVE_NETDB_H)
check_include_files (sys/socket.h CNF_HAVE_SYS_SOCKET_H)
check_include_files (arpa/inet.h CNF_HAVE_ARPA_INET_H)
check_include_files (netinet/in.h CNF_HAVE_NETINET_IN_H)
check_include_files (poll.h CNF_HAVE_POLL_H)
check_include_files (sys/select.h CNF_HAVE_SYS_SELECT_H)
check_include_files (io.h CNF_HAVE_IO_H)
check_include_files (process.h CNF_HAVE_PROCESS_H)
check_include_files (pthread.h CNF_HAVE_PTHREAD_H)
check_function_exists ("strcasecmp" CNF_HAVE_STRCASECMP)
check_function_exists ("stricmp" CNF_HAVE_STRICMP)
check_function_exists ("getpid" CNF_HAVE_GETPID)
check_function_exists ("_getpid" CNF_HAVE__GETPID)

check_function_exists ("clock_gettime" HAVE_CLOCK_GETTIME)
check_function_exists ("getaddrinfo" HAVE_GETADDRINFO)
check_function_exists ("gethostbyaddr" HAVE_GETHOSTBYADDR)
check_function_exists ("gethostbyaddr_r" HAVE_GETHOSTBYADDR_R)
check_function_exists ("gethostbyname" HAVE_GETHOSTBYNAME)
check_function_exists ("gethostbyname2" HAVE_GETHOSTBYNAME2)
check_function_exists ("gethostbyname_r" HAVE_GETHOSTBYNAME_R)
check_function_exists ("gethostname" HAVE_GETHOSTNAME)
check_function_exists ("getpid" HAVE_GETPID)
check_function_exists ("gettimeofday" HAVE_GETTIMEOFDAY)
check_function_exists ("htonl" HAVE_HTONL)
check_function_exists ("inet_aton" HAVE_INET_ATON)
check_function_exists ("inet_ntoa" HAVE_INET_NTOA)
check_function_exists ("inet_ntop" HAVE_INET_NTOP)
check_function_exists ("inet_pton" HAVE_INET_PTON)
check_include_files (inttypes.h HAVE_INTTYPES_H)
check_include_files (io.h HAVE_IO_H)
check_function_exists ("isdigit" HAVE_ISDIGIT)
check_include_files (limits.h HAVE_LIMITS_H)
check_function_exists ("localtime_r" HAVE_LOCALTIME_R)
check_function_exists ("malloc" HAVE_MALLOC)
check_include_files (memory.h HAVE_MEMORY_H)
check_function_exists ("memset" HAVE_MEMSET)
check_include_files (netdb.h HAVE_NETDB_H)
check_include_files (netinet/in.h HAVE_NETINET_IN_H)
check_function_exists ("poll" HAVE_POLL)
check_include_files (poll.h HAVE_POLL_H)
check_include_files (process.h HAVE_PROCESS_H)
check_include_files (pthread.h HAVE_PTHREAD) # :-(
check_function_exists ("realloc" HAVE_REALLOC)
check_function_exists ("select" HAVE_SELECT)
check_include_files (signal.h HAVE_SIGNAL_H)
check_function_exists ("socket" HAVE_SOCKET)
check_include_files (stdint.h HAVE_STDINT_H)
check_include_files (stdio.h HAVE_STDIO_H)
check_include_files (stdlib.h HAVE_STDLIB_H)
check_function_exists ("strcasecmp" HAVE_STRCASECMP)
check_function_exists ("strchr" HAVE_STRCHR)
check_function_exists ("strerror" HAVE_STRERROR)
check_function_exists ("stricmp" HAVE_STRICMP)
check_include_files (strings.h HAVE_STRINGS_H)
check_include_files (string.h HAVE_STRING_H)
check_function_exists ("strstr" HAVE_STRSTR)
check_include_files (sys/param.h HAVE_SYS_PARAM_H)
check_include_files (sys/select.h HAVE_SYS_SELECT_H)
check_include_files (sys/socket.h HAVE_SYS_SOCKET_H)
check_include_files (sys/stat.h HAVE_SYS_STAT_H)
check_include_files (sys/timeb.h HAVE_SYS_TIMEB_H)
check_include_files (sys/time.h HAVE_SYS_TIME_H)
check_include_files (sys/types.h HAVE_SYS_TYPES_H)
check_include_files (sys/unistd.h HAVE_SYS_UNISTD_H)
check_include_files (time.h HAVE_TIME_H)
check_include_files (unistd.h HAVE_UNISTD_H)
check_include_files (winsock2.h HAVE_WINSOCK2_H)
check_include_files (winsock.h HAVE_WINSOCK_H)
check_include_files (ws2tcpip.h HAVE_WS2TCPIP_H)
check_include_files (wspiapi.h HAVE_WSPIAPI_H)
check_function_exists ("_getpid" HAVE__GETPID)

check_type_size ("int64_t" SIZEOF_INT64_T LANGUAGE CXX)
check_type_size ("long long" SIZEOF_LONG_LONG LANGUAGE CXX)
check_type_size ("long" SIZEOF_LONG LANGUAGE CXX)
check_type_size ("uint64_t" SIZEOF_UINT64_T LANGUAGE CXX)
check_type_size ("unsigned long long" SIZEOF_ULONG_LONG LANGUAGE CXX)
check_type_size ("unsigned long" SIZEOF_ULONG LANGUAGE CXX)

if (SIZEOF_INT64_T EQUAL "8")
  set (TYPE_INT64_T "int64_t")
elseif (SIZEOF_LONG EQUAL "8")
  set (TYPE_INT64_T "long")
elseif (SIZEOF_LONG_LONG EQUAL "8")
  set (TYPE_INT64_T "long long")
else ()
  message (FATAL_ERROR "Can't find suitable int64_t")
endif ()
message (STATUS "Found int64_t: ${TYPE_INT64_T}")

if (SIZEOF_UINT64_T EQUAL "8")
  set (TYPE_UINT64_T "uint64_t")
elseif (SIZEOF_ULONG EQUAL "8")
  set (TYPE_INT64_T "unsigned long")
elseif (SIZEOF_ULONG_LONG EQUAL "8")
  set (TYPE_INT64_T "unsigned long long")
else ()
  message (FATAL_ERROR "Can't find suitable uint64_t")
endif ()
message (STATUS "Found uint64_t: ${TYPE_UINT64_T}")


set (SOCKADDR_HEADERS)
if (CNF_HAVE_WINSOCK2_H)
   set (SOCKADDR_HEADERS ${SOCKADDR_HEADERS} winsock2.h)
endif ()
if (CNF_HAVE_WS2TCPIP_H)
   set (SOCKADDR_HEADERS ${SOCKADDR_HEADERS} ws2tcpip.h)
endif ()
if (CNF_HAVE_WINSOCK_H)
   set (SOCKADDR_HEADERS ${SOCKADDR_HEADERS} winsock.h)
endif ()
if (CNF_HAVE_NETDB_H)
   set (SOCKADDR_HEADERS ${SOCKADDR_HEADERS} netdb.h)
endif ()
if (CNF_HAVE_SYS_SOCKET_H)
   set (SOCKADDR_HEADERS ${SOCKADDR_HEADERS} sys/socket.h)
endif ()
if (CNF_HAVE_ARPA_INET_H)
   set (SOCKADDR_HEADERS ${SOCKADDR_HEADERS} arpa/inet.h)
endif ()
if (CNF_HAVE_NETINET_IN_H)
   set (SOCKADDR_HEADERS ${SOCKADDR_HEADERS} netinet/in.h)
endif ()

check_struct_has_member ("struct sockaddr_storage"
            ss_family "${SOCKADDR_HEADERS}"
            CNF_HAVE_STRUCT_SOCKADDR_STORAGE_SS_FAMILY LANGUAGE CXX)

check_struct_has_member ("struct sockaddr_storage"
            __ss_family "${SOCKADDR_HEADERS}"
            CNF_HAVE_STRUCT_SOCKADDR_STORAGE___SS_FAMILY LANGUAGE CXX)


if (OPTION_SNMPv3)
  set (_SNMPv3 1)
  set (_NO_SNMPv3 0)
else ()
  set (_SNMPv3 0)
  set (_NO_SNMPv3 1)
endif ()

if (OPTION_IPv6)
   set (WITH_SNMP_PP_IPv6 1)
   set (SNMP_PP_IPv6 1)
else ()
   set (WITH_SNMP_PP_IPv6 0)
   set (SNMP_PP_IPv6 0)
endif ()

if (OPTION_THREADS)
  set (CMAKE_THREAD_PREFER_PTHREAD 1)
  if (APPLE)
    # assume built-in pthreads on MacOS
    set (CMAKE_THREAD_LIBS_INIT "-lpthread")
    set (CMAKE_HAVE_THREADS_LIBRARY 1)
    set (CMAKE_USE_WIN32_THREADS_INIT 0)
    set (CMAKE_USE_PTHREADS_INIT 1)
    set (THREADS_PREFER_PTHREAD_FLAG ON)
  else ()
    find_package (Threads)
  endif ()

   set (WITH_THREADS 1)
   if (CNF_HAVE_PTHREAD_H)
      set (WITH_PTHREAD 1)
   else ()
      set (WITH_PTHREAD 0)
   endif ()
else ()
  set (CMAKE_DISABLE_FIND_PACKAGE_Threads ON)
   set (WITH_THREADS 0)
   set (WITH_PTHREAD 0)
endif ()

if (OPTION_NAMESPACE)
   set (WITH_NAMESPACE 1)
else ()
   set (WITH_NAMESPACE 0)
endif ()

if (OPTION_LOGGING)
   set (WITH_LOGGING 1)
else ()
   set (WITH_LOGGING 0)
endif ()

if (OPTION_MACADDR)
   set (WITH_MACADDRESS 1)
else ()
   set (WITH_MACADDRESS 0)
endif ()

if (OPTION_IPXADDR)
   set (WITH_IPXADDRESS 1)
else ()
   set (WITH_IPXADDRESS 0)
endif ()

if (OPTION_EXTENDED_DEBUG)
   set (_DEBUG 1)
else ()
   set (_DEBUG 0)
endif ()


if (OPTION_OPENSSL)
  #set (OPENSSL_ROOT_DIR "/usr/local/opt/openssl")
  find_package (OpenSSL REQUIRED)

  if (OPENSSL_FOUND)
    message (STATUS "Found OpenSSL (include: ${OPENSSL_INCLUDE_DIR}, library: ${OPENSSL_LIBRARIES})")

    set (CRYPTO_INCLUDE_DIR ${OPENSSL_INCLUDE_DIR})
    set (CRYPTO_LINKLIBS ${OPENSSL_LIBRARIES})
  else (OPENSSL_FOUND)
    message (FATAL_ERROR "OpenSSL NOT found")
  endif (OPENSSL_FOUND)

  set (WITH_LIBSSL 1)
else ()
  set (WITH_LIBSSL 0)
endif ()

if (OPTION_LIBTOMCRYPT)
  find_package (TOMCRYPT)
  if (TOMCRYPT_FOUND)
    set (CRYPTO_INCLUDE_DIR ${TOMCRYPT_INCLUDE_DIR})
    set (CRYPTO_LINKLIBS ${TOMCRYPT_LIBRARIES})
  else (TOMCRYPT_FOUND)
    message (FATAL_ERROR " Libtomcrypt NOT found!")
  endif (TOMCRYPT_FOUND)

   set (WITH_LIBTOMCRYPT 1)
else ()
   set (WITH_LIBTOMCRYPT 0)
endif ()

if (OPTION_LIBDES)
  message (STATUS "Searching for libdes...")
  find_package (DES)

  if (DES_FOUND)
    message (STATUS "Libdes found / ${DES_INCLUDE_DIR} / ${DES_LIBRARIES} / ")
    set (CRYPTO_INCLUDE_DIR ${DES_INCLUDE_DIR})
    set (CRYPTO_LINKLIBS ${DES_LIBRARIES})
  else (DES_FOUND)
    message (FATAL_ERROR " Libdes NOT found!")
  endif (DES_FOUND)

  set (WITH_LIBDES 1)
else ()
   set (WITH_LIBDES 0)
endif ()


if (${LogProfile} STREQUAL "off")
  set (WITH_LOG_PROFILES 0)
else ()
  set (WITH_LOG_PROFILES 1)
  set (DEFAULT_LOG_PROFILE "${LogProfile}")
endif ()

if (CNF_STDC_HEADERS)
  set (STDC_HEADERS 1)
else ()
  set (STDC_HEADERS 0)
endif ()

if (CNF_STDCXX_98_HEADERS)
  set (STDCXX_98_HEADERS 1)
else ()
  set (STDCXX_98_HEADERS 0)
endif ()


check_type_size (size_t SIZE_T LANGUAGE CXX)
if (NOT HAVE_SIZE_T)
  if ("${CMAKE_SIZEOF_VOID_P}" EQUAL 8)
    set (size_t "uint64_t")
  else ("${CMAKE_SIZEOF_VOID_P}" EQUAL 8)
    set (size_t   "uint32_t")
  endif ("${CMAKE_SIZEOF_VOID_P}" EQUAL 8)
endif ()


check_include_files (malloc.h HAVE_MALLOC_H)
check_include_files ("sys/param.h;sys/mount.h" HAVE_SYS_MOUNT_H)
check_function_exists ("strcasecmp" HAVE_STRCASECMP)

configure_file (${CMAKE_CURRENT_SOURCE_DIR}/cmake_config.h.in ${CMAKE_CURRENT_SOURCE_DIR}/config.h)
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/cmake_libsnmp.h.in ${CMAKE_CURRENT_SOURCE_DIR}/libsnmp.h)
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/cmake_libsnmp.h.in ${CMAKE_CURRENT_SOURCE_DIR}/include/system/libsnmp.h)
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/include/snmp_pp/config_snmp_pp.h.in ${CMAKE_CURRENT_SOURCE_DIR}/include/snmp_pp/config_snmp_pp.h)

set (CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -DHAVE_CONFIG_H")

if (MSVC)
    # warning level 4 (all warnings as errors: /WX)
    add_compile_options (/W4 /WX)
else ()
    # Add "-Wextra -pedantic" to get more warnings
    add_compile_options (-Wall)
endif ()

include_directories (${CMAKE_BINARY_DIR})
include_directories (.)
include_directories (include)
include_directories (include/snmp_pp)
include_directories (include/system)
include_directories (snmp_pp)
include_directories (${CRYPTO_INCLUDE_DIR})

set (MY_HEADER_FILES
  include/snmp_pp/address.h
  include/snmp_pp/asn1.h
  include/snmp_pp/auth_priv.h
  include/snmp_pp/collect.h
  include/snmp_pp/config_snmp_pp.h
  include/snmp_pp/counter.h
  include/snmp_pp/ctr64.h
  include/snmp_pp/eventlist.h
  include/snmp_pp/eventlistholder.h
  include/snmp_pp/gauge.h
  include/snmp_pp/idea.h
  include/snmp_pp/integer.h
  include/snmp_pp/IPv6Utility.h
  include/snmp_pp/log.h
  include/snmp_pp/md5.h
  include/snmp_pp/mp_v3.h
  include/snmp_pp/msec.h
  include/snmp_pp/msgqueue.h
  include/snmp_pp/notifyqueue.h
  include/snmp_pp/octet.h
  include/snmp_pp/oid.h
  include/snmp_pp/oid_def.h
  include/snmp_pp/pdu.h
  include/snmp_pp/reentrant.h
  include/snmp_pp/sha.h
  include/snmp_pp/smi.h
  include/snmp_pp/smival.h
  include/snmp_pp/snmp_pp.h
  include/snmp_pp/snmperrs.h
  include/snmp_pp/snmpmsg.h
  include/snmp_pp/target.h
  include/snmp_pp/timetick.h
  include/snmp_pp/userdefined.h
  include/snmp_pp/usertimeout.h
  include/snmp_pp/usm_v3.h
  include/snmp_pp/uxsnmp.h
  include/snmp_pp/v3.h
  include/snmp_pp/vb.h
)

set (MY_HEADER_LIB_FILES
  libsnmp.h
)

set (MY_SRC_FILES
  src/address.cpp
  src/asn1.cpp
  src/auth_priv.cpp
  src/counter.cpp
  src/ctr64.cpp
  src/eventlist.cpp
  src/eventlistholder.cpp
  src/gauge.cpp
  src/idea.cpp
  src/integer.cpp
  src/IPv6Utility.cpp
  src/log.cpp
  src/md5c.cpp
  src/mp_v3.cpp
  src/msec.cpp
  src/msgqueue.cpp
  src/notifyqueue.cpp
  src/octet.cpp
  src/oid.cpp
  src/pdu.cpp
  src/reentrant.cpp
  src/sha.cpp
  src/snmpmsg.cpp
  src/target.cpp
  src/timetick.cpp
  src/userdefined.cpp
  src/usertimeout.cpp
  src/usm_v3.cpp
  src/uxsnmp.cpp
  src/v3.cpp
  src/vb.cpp
)

link_libraries (${CRYPTO_LINKLIBS})

add_library (snmp++ SHARED
  ${MY_HEADER_FILES}
  ${MY_HEADER_LIB_FILES}
  config.h
  ${MY_SRC_FILES}
)

set_property (TARGET snmp++ PROPERTY POSITION_INDEPENDENT_CODE 1)
# Set .so version as autoconf does: snmp++ version 1.2.3 will go to .so.12.0.3!
set_target_properties (snmp++ PROPERTIES VERSION ${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR}.0.${PROJECT_VERSION_PATCH} SOVERSION ${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR})

set (EXAMPLE_SOURCE_FILES
  consoleExamples/receive_trap.cpp
  consoleExamples/snmpBulk.cpp
  consoleExamples/snmpDiscover.cpp
  consoleExamples/snmpGet.cpp
  consoleExamples/snmpInform.cpp
  consoleExamples/snmpNext.cpp
  consoleExamples/snmpNextAsync.cpp
  consoleExamples/snmpPasswd.cpp
  consoleExamples/snmpSet.cpp
  consoleExamples/snmpTraps.cpp
  consoleExamples/snmpWalk.cpp
  consoleExamples/snmpWalkThreads.cpp
  consoleExamples/test_app.cpp
)

foreach (examplesourcefile ${EXAMPLE_SOURCE_FILES})
    string (REPLACE ".cpp" "" examplename ${examplesourcefile})
    string (REPLACE "consoleExamples/" "" examplename ${examplename})
    add_executable (${examplename} ${examplesourcefile})
    target_link_libraries (${examplename} snmp++)
    if (WITH_THREADS)
      if (NOT APPLE)
        target_link_libraries (${examplename} Threads::Threads)
      endif (NOT APPLE)
    endif ()

endforeach (examplesourcefile ${EXAMPLE_SOURCE_FILES})

add_library (snmp++_static STATIC
  ${MY_HEADER_FILES}
  ${MY_SRC_FILES}
)

install (TARGETS snmp++ DESTINATION lib)
install (TARGETS snmp++_static DESTINATION lib)
install (FILES ${MY_HEADER_LIB_FILES} DESTINATION include)
install (FILES ${MY_HEADER_FILES} DESTINATION include/snmp_pp)

