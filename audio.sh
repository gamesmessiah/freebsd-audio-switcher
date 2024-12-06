#! /bin/sh

# Author: Cameron Taylor
# gemini://camerontaylor.uk
# gopher://camerontaylor.uk
# i3wm setup deployment script
# FreeBSD Desktop
# Version 0.1

########################################################################################
#        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
########################################################################################

# Function to change audio output
change_audio_output() {
    case $1 in
        "1")
            # Change to headphones
            sysctl hw.snd.default_unit=1
            echo "Audio output changed to Headphones."
            ;;
        "2")
            # Change to speakers
            sysctl hw.snd.default_unit=0
            echo "Audio output changed to Speakers."
            ;;
        "q")
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1, 2, or q."
            ;;
    esac
}

while true; do
    echo "Select audio output:"
    echo "1) Headphones"
    echo "2) Speakers"
    echo "q) Quit"
    
    read -r choice
    change_audio_output "$choice"
done
