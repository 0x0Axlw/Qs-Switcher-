import Quickshell
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell.Wayland

// Entry point. Its only job is to assemble the pieces:
//   - the layer-shell window
//   - the wallpaper source (model)
//   - the carousel UI
// Behavior, state and styling now live in their own files.
PanelWindow {
    id: main

    implicitHeight: Theme.windowHeight
    implicitWidth: Screen.width
    color: "transparent"

    aboveWindows: true
    exclusionMode: "Ignore"
    exclusiveZone: 1

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // Kick off background thumbnail generation as soon as we launch.
    Component.onCompleted: {
        Quickshell.execDetached(["bash", Quickshell.shellPath("cache.sh"), Quickshell.shellDir])
    }

    FolderListModel {
        id: folderModel
        folder: "file://" + Config.wallpaperPath
        showDirs: false
        nameFilters: ["*.png", "*.jpg"]
        sortField: FolderListModel.Name
    }

    WallpaperCarousel {
        anchors.fill: parent
        focus: true
        model: folderModel
    }
}
