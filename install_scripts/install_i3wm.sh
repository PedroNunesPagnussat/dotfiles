curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
sudo apt install apt-transport-https --yes
echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild-ubuntu/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
sudo apt update
sudo apt install -y i3
sudo apt install -y feh
sudo apt install -y rofi
sudo apt install -y cava
sudo apt install -y polybar
sudo apt install -y i3lock
sudo apt install -y picom
sudo apt install -y libconfig-dev
sudo apt install -y libdbus-1-dev
sudo apt install -y libegl-dev
sudo apt install -y libev-dev
sudo apt install -y libgl-dev
sudo apt install -y libepoxy-dev
sudo apt install -y libpcre2-dev
sudo apt install -y libpixman-1-dev
sudo apt install -y libx11-xcb-dev
sudo apt install -y libxcb1-dev
sudo apt install -y libxcb-composite0-dev
sudo apt install -y libxcb-damage0-dev
sudo apt install -y libxcb-glx0-dev
sudo apt install -y libxcb-image0-dev
sudo apt install -y libxcb-present-dev
sudo apt install -y libxcb-randr0-dev
sudo apt install -y libxcb-render0-dev
sudo apt install -y libxcb-render-util0-dev
sudo apt install -y libxcb-shape0-dev
sudo apt install -y libxcb-util-dev
sudo apt install -y libxcb-xfixes0-dev
sudo apt install -y libxext-dev
sudo apt install -y meson
sudo apt install -y ninja-build
sudo apt install -y uthash-dev
sudo apt install -y i3lock


