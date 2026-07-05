import QtQuick
import Quickshell

// Center-locked carousel (PS5 / Big Picture style).
// The current tile is pinned to the middle of the screen; the whole row
// of tiles flows THROUGH that point. Selection is "whichever tile is at
// the center", so there is no border/cursor to move.
//
// PathView is the Qt Quick component built for exactly this: we lay tiles
// along a straight horizontal Path and let the engine keep `currentIndex`
// at path position 0.5 (the center).
PathView {
    id: view

    // Width of a single tile. Path spacing is separate (see `path` below),
    // so this only controls how big each tile is drawn.
    property real tileWidth: width / Config.numberOfPictures - 10

    // How many tiles exist on the path at once (virtualized; offscreen
    // tiles aren't created).
    pathItemCount: Config.numberOfPictures

    // Pin the current item to the center and scroll the world around it.
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    highlightRangeMode: PathView.StrictlyEnforceRange
    snapMode: PathView.SnapToItem

    // Smooth, GPU-friendly slide when currentIndex changes.
    highlightMoveDuration: Theme.highlightMoveDuration

    // A straight horizontal line at vertical center. Tiles are placed with
    // their center on this line, so the centered tile sits at width/2.
    path: Path {
        startX: 0
        startY: view.height / 2
        PathLine {
            x: view.width
            y: view.height / 2
        }
    }

    delegate: WallpaperTile {}

    // --- selection / actions ----------------------------------------

    function activateCurrent() {
        const path = model.get(currentIndex, "filePath")
        Quickshell.execDetached(["bash", Quickshell.shellPath("commands.sh"), path])
        Qt.quit()
    }

    // --- keyboard ----------------------------------------------------

    Keys.onPressed: function(event) {
        const big = Config.numberOfPictures

        if (event.key === Qt.Key_J) {
            incrementCurrentIndex()
        } else if (event.key === Qt.Key_K) {
            decrementCurrentIndex()
        } else if (event.key === Qt.Key_D) {
            currentIndex = Math.min(count - 1, currentIndex + big)
        } else if (event.key === Qt.Key_U) {
            currentIndex = Math.max(0, currentIndex - big)
        } else if (event.key === Qt.Key_Space || event.key === Qt.Key_Return) {
            activateCurrent()
        } else if (event.key === Qt.Key_Escape) {
            Qt.quit()
        } else {
            return
        }

        event.accepted = true
    }
}
