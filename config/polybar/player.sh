playerctl status 2>/dev/null | grep -q "Playing" && echo "%{F#a6e3a1} $(playerctl metadata --format "{{ title }} - {{ artist }}")%{F-}" || playerctl status 2>/dev/null | grep -q "Paused" && echo "%{F#fab387}■ $(playerctl metadata --format "{{ title }} - {{ artist }}")%{F-}" || echo "%{F#f38ba8}■ Not Playing%{F-}"

