sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_spi 1
sudo raspi-config nonint do_serial_hw 0
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint disable_raspi_config_at_boot 0
# Enable 1Wire
echo "dtoverlay=pwm-2chan" | sudo tee -a /boot/firmware/config.txt
echo "dtparam=sd_cqe=0" | sudo tee -a /boot/firmware/config.txt # https://forums.raspberrypi.com/viewtopic.php?p=2287745#p2287745
echo "dtparam=i2c_arm_baudrate=10000" | sudo tee -a /boot/firmware/config.txt

sudo apt update
sudo apt install -y python3-pip git i2c-tools libgpiod-dev python3-libgpiod python3-scipy
sudo python3 -m pip config set global.break-system-packages true
sudo pip3 install --break-system-packages --upgrade adafruit-blinka

sudo apt remove python3-rpi.gpio
sudo pip3 uninstall --break-system-packages  -y RPi.GPIO
sudo pip3 install --break-system-packages --upgrade rpi-lgpio

sudo pip3 install --break-system-packages --upgrade adafruit-circuitpython-amg88xx adafruit-circuitpython-rplidar adafruit-circuitpython-motor adafruit-circuitpython-bno055
sudo pip3 install --break-system-packages --upgrade bless scipy numpy filterpy rpi-hardware-pwm

git config --global init.defaultBranch main
git clone "https://github.com/spartanrobot/bt_ip.git"
sudo chown -R admin bt_ip
# Might need to add system dependencies for bless
sudo cp /home/admin/bt_ip/bt_ip.service /lib/systemd/system/bt_ip.service
sudo chmod 644 /lib/systemd/system/bt_ip.service
sudo systemctl daemon-reload
sudo systemctl enable bt_ip.service

# Fix GPIO issues
sudo pip3 uninstall --break-system-packages -y adafruit-blinka
sudo pip3 install --break-system-packages "git+https://github.com/frank-pet/Adafruit_Blinka.git@651192bdb5c1d97e5d5e401e0dd17a0d65c15371"

sudo pip3 install --break-system-packages "git+https://github.com/simondlevy/BreezySLAM.git#egg=breezyslam&subdirectory=python"

read -p "Do you want to reboot now? [Y/n] " confirm < /dev/tty
if [[ $confirm =~ ^[Yy]$ ]]
then
    sudo reboot
fi

