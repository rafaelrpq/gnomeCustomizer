flathub () {
    sudo apt install flatpak gnome-software-plugin-flatpak -y

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    echo "abi <abi/4.0>,"                                                           >> bwrap
    echo "include <tunables/global>"                                                >> bwrap
    echo ""                                                                         >> bwrap
    echo "profile bwrap /usr/bin/bwrap flags=(unconfined) {"                        >> bwrap
    echo "  userns,"                                                                >> bwrap
    echo ""                                                                         >> bwrap
    echo "  # Site-specific additions and overrides. See local/README for details." >> bwrap
    echo "  include if exists <local/bwrap>"                                        >> bwrap
    echo "}"                                                                        >> bwrap

    sudo mv bwrap /etc/apparmor.d/bwrap
    sudo systemctl reload apparmor
}

globalMenu () {
    FILDEM=~/.config/autostart/fildem.desktop

    sudo apt install git make
    git clone https://github.com/sominemo/Fildem-Gnome-45/
    cd Fildem-Gnome-45
    make
    sudo apt install ./fildem_0.6.7_all.deb -y
    
    mkdir -p ~/.config/autostart
    
    echo "[Desktop Entry]"                 > $FILDEM
    echo "Type=Application"               >> $FILDEM
    echo "Exec=fildem"                    >> $FILDEM
    echo "Hidden=false"                   >> $FILDEM
    echo "NoDisplay=false"                >> $FILDEM
    echo "X-GNOME-Autostart-enabled=true" >> $FILDEM
    echo "Name[pt_BR]=fildem"             >> $FILDEM
    echo "Name=fildem"                    >> $FILDEM
    echo "Comment[pt_BR]=global menu"     >> $FILDEM
    echo "Comment=global menu"            >> $FILDEM
}

extensionsConf () {
    
}

flathub > > /dev/null 2>&1
globalMenu > /dev/null 2>&1
gnome-session-quit