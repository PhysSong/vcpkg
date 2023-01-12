vcpkg_download_distfile(ARCHIVE
    URLS "https://download.linuxsampler.org/packages/libgig-4.3.0.tar.bz2"
    FILENAME "libgig-4.3.0.tar.bz2"
    SHA512 683c09b1d17acf69020c631452b7dfb25ac54c3701db5e97471d4e7973e9a06267667bf19bfe4eb00d2964223e8446f248d93b4cf29c062dec2588758b4dfba2
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES
        0001-msvc-fix-ssize_t.patch
        0002-always-allow-cmake.patch
        0003-fix-linux-build.patch
)

string(COMPARE EQUAL ${VCPKG_LIBRARY_LINKAGE} dynamic LIBGIG_BUILD_SHARED)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        extra-tools LIBGIG_BUILD_TOOLS
        tests LIBGIG_ENABLE_TESTING
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DLIBGIG_BUILD_SHARED=${LIBGIG_BUILD_SHARED}
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()
vcpkg_cmake_config_fixup()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
