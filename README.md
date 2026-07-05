# Qs-Switcher

Wallpaper selector made using quickshell.

> [!IMPORTANT]
> Make sure to read the entire config and usage section before using

## Demo

https://github.com/user-attachments/assets/375e3696-e62d-48bf-8af6-18d2be86b224


## Dependencies

- [quickshell](https://git.outfoxxed.me/quickshell/quickshell)

## Installation

Now just clone this repo into Quickshell's config folder

```bash
git clone  https://github.com/0x0Axlw/Qs-Switcher-.git ~/.config/quickshell/Qs-Switcher
```

## config

go to the `config.json` file and change the `"wallpaper_path"` and the `"cache_path"` variables

> [!IMPORTANT]
> Make sure to use absolute path (/home/...) for the path and put the trailing "/" at the end of the path

Example config.json
```
{
    "wallpaper_path": "/home/<username>/Pictures/Wallpapers/",
    "cache_path": "/home/<username>/.cache/quickshell/thumbs/",
    "number_of_pictures": 7,
    "border_color": "#C27B63",
    "cache_batch_size": 20
}
```

Also add your wallpaper changing commands to the `commands.sh` file. Selecting a wallpaper runs the command with the path to the wallpaper passed as a parameter. An example on how to use it with swww is given.

```{bash}
swww img $1 -t grow --transition-duration 1
```

### Keybinds:

- J/K to scroll to 1 left/right respectively
- D/U to scroll 1 screen worth left/right respectively
- Esc to quit out
- Space/Enter(or return) to select wallpaper
- Scrolling/click and dragging also works for scrolling
- Clicking also allows selection of a wallpaper
