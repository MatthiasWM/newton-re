# The reconstruction as one ESP-IDF component: the tree's sources
# (newton_sources.cmake, made by tools/tdeck/idf_sources.py) and the
# device's own host code beside this file.
get_filename_component(NEWTON_SRC ${CMAKE_CURRENT_LIST_DIR}/../../.. ABSOLUTE)
include(${CMAKE_CURRENT_LIST_DIR}/newton_sources.cmake)

set(sources)
foreach(s ${NEWTON_SOURCES})
    list(APPEND sources ${NEWTON_SRC}/${s})
endforeach()
list(APPEND sources ${NEWTON_FORWARDED})
# (the DDK's own directory as -I too: three of its headers include others
#  with <...>, and none of its file names is a system header's)
idf_component_register(SRCS esp32main.cpp newtonmain.cpp esp32runtime.cpp ${sources}
                       INCLUDE_DIRS . ${NEWTON_SRC}/ddk
                       REQUIRES driver esp_partition spi_flash esp_timer esp_psram vfs freertos)

# the flags the tree is built with everywhere (src/CMakeLists.txt): the
# DDK configured for the MessagePad, host_compat.h first, signed overflow
# wrapping, chars signed, every function four-byte aligned; C++17 as on
# the desktop; and quiet - the tree's warnings are the desktop build's
# business
# Each source's include directories, as the desktop build gives them and in
# its order (newton_sources.cmake's groups: headers of one name live in more
# than one directory).  As -iquote, searched for "..." includes only: as -I,
# src/intl/Locale.h would be found for the C library's <locale.h> on a
# case-insensitive file system.
math(EXPR last "${NEWTON_GROUP_COUNT} - 1")
foreach(n RANGE ${last})
    set(quoted)
    foreach(d ${NEWTON_GROUP_${n}_INCLUDES})
        list(APPEND quoted -iquote${NEWTON_SRC}/${d})
    endforeach()
    set(files)
    foreach(s ${NEWTON_GROUP_${n}_SOURCES})
        if(s MATCHES "^forwarded/")
            list(APPEND files ${CMAKE_CURRENT_LIST_DIR}/${s})
        else()
            list(APPEND files ${NEWTON_SRC}/${s})
        endif()
    endforeach()
    set_source_files_properties(${files} PROPERTIES COMPILE_OPTIONS "${quoted}")
endforeach()
# (the device's own files: the directories of the headers they include)
set_source_files_properties(newtonmain.cpp esp32runtime.cpp PROPERTIES COMPILE_OPTIONS
    "-iquote${NEWTON_SRC};-iquote${NEWTON_SRC}/frames;-iquote${NEWTON_SRC}/toolbox;-iquote${NEWTON_SRC}/utility;-iquote${NEWTON_SRC}/protocols;-iquote${NEWTON_SRC}/memory;-iquote${NEWTON_SRC}/os600/user;-iquote${NEWTON_SRC}/os600/kernel;-iquote${NEWTON_SRC}/host")

target_compile_definitions(${COMPONENT_LIB} PRIVATE forQ=1 NDEBUG)
target_compile_options(${COMPONENT_LIB} PRIVATE
    -include${NEWTON_SRC}/host/host_compat.h
    -fwrapv -fsigned-char -falign-functions=4 -w
    $<$<COMPILE_LANGUAGE:CXX>:-std=gnu++17>)
