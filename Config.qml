pragma Singleton

import Quickshell
import Quickshell.Io

// Single source of truth for user settings (config.json).
// Because it's a Singleton, ANY file can read `Config.cachePath` etc.
// without it being passed down by hand.
Singleton {
    id: root

    // Expose nice camelCase names to the rest of the app, while the
    // JsonAdapter below keeps the snake_case keys that match the JSON file.
    property alias wallpaperPath: adapter.wallpaper_path
    property alias cachePath: adapter.cache_path
    property alias numberOfPictures: adapter.number_of_pictures
    property alias borderColor: adapter.border_color

    FileView {
        path: Quickshell.shellPath("config.json")
        watchChanges: true
        onFileChanged: reload() // live-reload when you edit config.json

        JsonAdapter {
            id: adapter
            property string wallpaper_path
            property string cache_path
            property int number_of_pictures
            property string border_color
        }
    }
}
