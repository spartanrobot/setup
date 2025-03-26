# Assumes you're using the system Python3 installation (for all users)

# TODO: Enable 1Wire

# Fixes persistent SD card brickification
echo "dtparam=sd_cqe=0" | sudo tee -a /boot/firmware/config.txt # https://forums.raspberrypi.com/viewtopic.php?p=2287745#p2287745


sudo apt update
sudo apt install -y python3-pip git i2c-tools libgpiod-dev python3-libgpiod
sudo pip3 install --break-system-packages --upgrade adafruit-blinka

sudo apt remove python3-rpi.gpio
sudo pip3 uninstall --break-system-packages  -y RPi.GPIO
sudo pip3 install --break-system-packages --upgrade rpi-lgpio

# Add all other adafruit-circuitpython-xyz packages on this line: sudo pip3 install --break-system-packages --upgrade 

# Fix GPIO issues
sudo pip3 uninstall --break-system-packages -y adafruit-blinka
sudo pip3 install --break-system-packages "git+https://github.com/frank-pet/Adafruit_Blinka.git@651192bdb5c1d97e5d5e401e0dd17a0d65c15371"

read -p "Do you want to reboot now? [Y/n] " confirm < /dev/tty
if [[ $confirm =~ ^[Yy]$ ]]
then
    sudo reboot
fi

