#!/usr/bin/env fish
function toggle_theme

    set alacritty_config ~/.config/alacritty/alacritty.toml
    set vimrc (realpath ~/.vimrc)

    set alacritty_light "themes/github_light_high_contrast"
    set alacritty_dark "themes/github_dark_high_contrast"

    set current_theme (grep 'let g:theme = "light"' $vimrc >/dev/null; and echo "light"; or echo "dark")

    if test "$current_theme" = "light"
        echo "Switching to dark theme..."
        sed -i '' "s|$alacritty_light|$alacritty_dark|" $alacritty_config
        sed -i '' 's|let g:theme = "light"|let g:theme = "dark"|' $vimrc
    else
        echo "Switching to light theme..."
        sed -i '' "s|$alacritty_dark|$alacritty_light|" $alacritty_config
        sed -i '' 's|let g:theme = "dark"|let g:theme = "light"|' $vimrc
    end

    echo "Theme switched."

end
