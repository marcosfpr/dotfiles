##!/usr/bin/env fish
function build_wiki
    echo "Building wiki..."
    vim -R -c ':VimwikiIndex' -c ':VimwikiAll2HTML' -c 'qa!' < /dev/tty
    echo "Wiki build complete."
end
