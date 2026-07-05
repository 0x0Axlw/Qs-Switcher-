import QtQuick

// One wallpaper tile, used as the PathView delegate.
// It reads model roles as `required` properties, and reads its
// "am I selected?" state from PathView attached properties.
//
// There is NO selection border: being centered means being bigger,
// brighter and on top. That IS the indicator.
Item {
    id: tile

    required property int index
    required property string fileName

    // PathView.isCurrentItem is true for the tile currently at center.
    readonly property bool active: PathView.isCurrentItem

    width: PathView.view.tileWidth
    height: Theme.tileHeight

    // Selection feel: centered tile grows, others shrink/dim/sit behind.
    scale: active ? Theme.activeScale : Theme.inactiveScale
    opacity: active ? 1.0 : Theme.inactiveOpacity
    z: active ? 100 : 0

    // Animate scale/opacity on the GPU as selection moves between tiles.
    Behavior on scale {
        NumberAnimation { duration: Theme.tileTransitionDuration; easing.type: Easing.OutCubic }
    }
    Behavior on opacity {
        NumberAnimation { duration: Theme.tileTransitionDuration; easing.type: Easing.OutCubic }
    }

    Text {
        id: alt
        text: "Loading..."
        color: Config.borderColor
        anchors.centerIn: parent
        font.pixelSize: 16
        transform: Shear { xFactor: Theme.shearFactor }
    }

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: false
        smooth: true

        source: "file://" + Config.cachePath + tile.fileName
        sourceSize.width: width
        sourceSize.height: height

        transform: Shear { xFactor: Theme.shearFactor }

        Timer {
            id: retryTimer
            interval: 1000
            repeat: false
            onTriggered: {
                let s = img.source
                img.source = ""
                img.source = s
            }
        }

        onStatusChanged: {
            if (status === Image.Error) {
                alt.text = "Caching"
                retryTimer.start()
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        // Click a side tile to bring it to center; click the centered
        // tile (or Enter) to apply it.
        onClicked: {
            if (tile.active)
                PathView.view.activateCurrent()
            else
                PathView.view.currentIndex = tile.index
        }

        onWheel: function(wheel) {
            if (wheel.angleDelta.y > 0)
                PathView.view.decrementCurrentIndex()
            else
                PathView.view.incrementCurrentIndex()
            wheel.accepted = true
        }
    }
}
