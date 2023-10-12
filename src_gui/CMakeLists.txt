qt_add_library(guiModule)

qt_add_qml_module(guiModule
        URI "guiModule"
        VERSION 1.0
        QML_FILES Main.qml
        RESOURCE_PREFIX /
)
