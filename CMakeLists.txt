cmake_minimum_required(VERSION 3.16)

project(RecipeManager VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup()

qt_add_executable(appRecipeManager)

add_subdirectory(src)
add_subdirectory(include)

qt_add_qml_module(appRecipeManager
        URI RecipeManager
        VERSION 1.0
        QML_FILES src_gui/Main.qml
)

target_include_directories(appRecipeManager PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(appRecipeManager
    PRIVATE Qt6::Quick
    PRIVATE Qt${QT_VERSION_MAJOR}::Sql
)

set_target_properties(appRecipeManager PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

install(TARGETS appRecipeManager
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
