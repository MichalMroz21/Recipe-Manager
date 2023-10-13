set(INCLUDE_FILES
    managerdb.hpp
    debug_interceptor.hpp
    CMakeConfig.hpp
)

target_sources(appRecipeManager PRIVATE
    ${INCLUDE_FILES}
)
