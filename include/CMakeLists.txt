file(GLOB FOLDER_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.hpp)

target_sources(appRecipeManager PRIVATE
    ${FOLDER_FILES}
)
