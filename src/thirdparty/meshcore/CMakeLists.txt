# MeshCore (the LoRa mesh chat protocol) with the libraries it needs, as
# vendored from the owner's lilyphone1 firmware (README.md here says what
# came from where, and what was changed).  The radio-independent part only:
# MeshCore's core and chat helpers, rweather's Crypto (AES, SHA, Ed25519
# verification), orlp's ed25519 (keys, signing, key exchange) and Densaugeo's
# base64.  RadioLib and MeshCore's RadioLib wrappers are the T-Deck Pro's
# (src/host/esp32/main/CMakeLists.txt); a desktop's radio is the host mesh
# engine's pretend one (hal/host/HostMeshAir.cpp).
#
# Built without the Newton's include paths or its forced host_compat.h:
# compat/ stands in for the little of Arduino the sources include.  The
# contact and channel counts change BaseChatMesh's layout, so they are
# PUBLIC: everything that includes MeshCore's headers must agree on them.
enable_language(C)

set(MC ${CMAKE_CURRENT_SOURCE_DIR}/MeshCore/src)
set(CR ${CMAKE_CURRENT_SOURCE_DIR}/Crypto/src)
set(ED ${CMAKE_CURRENT_SOURCE_DIR}/ed25519/src)

add_library(meshcore STATIC
    ${MC}/Dispatcher.cpp
    ${MC}/Identity.cpp
    ${MC}/Mesh.cpp
    ${MC}/Packet.cpp
    ${MC}/Utils.cpp
    ${MC}/helpers/AdvertDataHelpers.cpp
    ${MC}/helpers/BaseChatMesh.cpp
    ${MC}/helpers/StaticPoolPacketManager.cpp
    ${MC}/helpers/TxtDataHelpers.cpp
    ${CR}/AES128.cpp
    ${CR}/AES192.cpp
    ${CR}/AES256.cpp
    ${CR}/AESCommon.cpp
    ${CR}/BigNumberUtil.cpp
    ${CR}/BlockCipher.cpp
    ${CR}/Crypto.cpp
    ${CR}/Curve25519.cpp
    ${CR}/Ed25519.cpp
    ${CR}/Hash.cpp
    ${CR}/SHA256.cpp
    ${CR}/SHA512.cpp
    ${ED}/add_scalar.c
    ${ED}/fe.c
    ${ED}/ge.c
    ${ED}/key_exchange.c
    ${ED}/keypair.c
    ${ED}/sc.c
    ${ED}/sha512.c
    ${ED}/sign.c
    ${ED}/verify.c
    compat/CryptoRNG.cpp
)
target_include_directories(meshcore SYSTEM PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/compat
    ${MC}
    ${CR}
    ${ED}
    ${CMAKE_CURRENT_SOURCE_DIR}/base64/src
)
target_compile_definitions(meshcore PUBLIC MAX_CONTACTS=64 MAX_GROUP_CHANNELS=4 ED25519_NO_SEED=1)
# third-party code: its own warnings are not the reconstruction's
target_compile_options(meshcore PRIVATE -w)
