#!/bin/bash
set -eu
# ==================================================================================== # # VARIABLES
# ==================================================================================== #
# Set the timezone for the server. A full list of available timezones can be found by # running timedatectl list-timezones.
TIMEZONE=Africa/Lagos

# Set the name of the new user to create.
USERNAME=ikehakinyemi

# Force all output to be presented in en_US for the duration of this script. This avoids # any "setting locale failed" errors while this script is running, before we have
# installed support for all locales. Do not change this setting!
export LC_ALL=en_US.UTF-8

# ==================================================================================== # # SCRIPT LOGIC
# ==================================================================================== #
# Enable the "universe" repository.
add-apt-repository --yes universe

# Update all software packages. Using the --force-confnew flag means that configuration # files will be replaced if newer ones are available.
apt update
apt --yes -o Dpkg::Options::="--force-confnew" upgrade

# Set the system timezone and install all locales.
timedatectl set-timezone ${TIMEZONE} 
apt --yes install locales-all

# Add the new user (and give them sudo privileges).
useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"

# Force a password to be set for the new user the first time they log in.
passwd --delete "${USERNAME}" 
chage --lastday 0 "${USERNAME}"

# Copy the SSH keys from the root user to the new user.
rsync --archive --chown=${USERNAME}:${USERNAME} /root/.ssh /home/${USERNAME}

# Configure the firewall to allow SSH, HTTP and HTTPS traffic.
ufw allow 22
ufw allow 80/tcp 
ufw allow 443/tcp 
ufw --force enable

# Install fail2ban.
apt --yes install fail2ban

echo "Script complete! Rebooting..." 
reboot