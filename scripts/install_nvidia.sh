sudo pacman -S nvidia -y
sudo pacman -S nvidia-utils nvidia-settings -y
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sudo mkinitcpio -P
sudo mkinitcpio -P
sudo reboot

