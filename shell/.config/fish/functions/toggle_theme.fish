#!/usr/bin/env fish
function toggle_theme

    set alacritty_config ~/.config/alacritty/alacritty.toml
    set vimrc (realpath ~/.vimrc)

    set alacritty_light "themes/seoul"
    set alacritty_dark "themes/kanagawa_dragon"

    set current_theme (grep 'let g:theme = "light"' $vimrc >/dev/null; and echo "light"; or echo "dark")

    if test "$current_theme" = "light"
        echo "Switching to dark theme..."
        sed -i '' 's|let g:theme = "light"|let g:theme = "dark"|' $vimrc
        sed -i '' "s|$alacritty_light|$alacritty_dark|" $alacritty_config
    else
        echo "Switching to light theme..."
        sed -i '' "s|$alacritty_dark|$alacritty_light|" $alacritty_config
        sed -i '' 's|let g:theme = "dark"|let g:theme = "light"|' $vimrc
    end

    echo "Theme switched."

end
