# TPinPad, the ROM's TDrawInterface (alert/PinPad.h), over a host display
add_executable(test_PinPad test_PinPad.cpp)
target_link_libraries(test_PinPad PRIVATE alert hal_host_display)
target_compile_definitions(test_PinPad PRIVATE "NEWTON_OBJECTS=\"${NEWTON_OBJECTS_FILE}\"")
add_test(NAME alert.PinPad COMMAND test_PinPad)
set_tests_properties(alert.PinPad PROPERTIES TIMEOUT 60)
