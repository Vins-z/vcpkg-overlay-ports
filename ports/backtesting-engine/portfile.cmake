vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Vins-z/Backtesting-Engine
    REF v1.1.0
    SHA512 f902e5f281403f5de23fc564aaf7043a34b7a2027a6e058a6be90bb6b2a7cfc7cbf0e59551988475ef796c233a71ebc1bd5400ec2756014aa6edec7b78e798db
    HEAD_REF master
)

set(PROJECT_SUBDIR "${SOURCE_PATH}/cpp-backtesting-engine")

# Upstream v1.1.0 uses find_package() directly for curl/yaml-cpp/eigen/spdlog/nlohmann_json
# and has BACKTESTINGENGINE_ENABLE_TALIB / BACKTESTINGENGINE_BUILD_EXAMPLES toggles, so no
# CMakeLists vendoring is needed here.

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/usage")
    file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
        DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
    )
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${PROJECT_SUBDIR}"
    OPTIONS
        -DBACKTESTINGENGINE_BUILD_EXAMPLES=OFF
        -DBACKTESTINGENGINE_ENABLE_TALIB=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/BacktestingEngine PACKAGE_NAME BacktestingEngine)

# Installed CMake config references tools/${PORT}/ (post-fixup); copy from bin so imported targets resolve.
vcpkg_copy_tools(TOOL_NAMES backtest_engine backtest_server AUTO_CLEAN)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

if(EXISTS "${PROJECT_SUBDIR}/LICENSE")
    vcpkg_install_copyright(FILE_LIST "${PROJECT_SUBDIR}/LICENSE")
elseif(EXISTS "${SOURCE_PATH}/LICENSE")
    vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
endif()

