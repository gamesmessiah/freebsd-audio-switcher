#!/bin/sh
# FreeBSD Dynamic Audio Switcher via PulseAudio and dmenu

# Get list of sinks formatted as: "sink_index: Description"
SINKS=$(pactl list sinks | awk '
    /^Sink #/ { id=substr($2, 2) }
    /Description:/ { sub(/^[ \t]*Description: /, ""); print id ": " $0 }
')

if [ -z "$SINKS" ]; then
    notify-send "Audio Switcher" "No PulseAudio sinks found."
    exit 1
fi

# Select sink via dmenu
SELECTED=$(echo "$SINKS" | dmenu -i -p "Select Audio Output:" -l 10)

[ -z "$SELECTED" ] && exit 0

# Extract the sink ID
SINK_ID=$(echo "$SELECTED" | awk -F':' '{print $1}')

# Set default sink for new streams
pactl set-default-sink "$SINK_ID"

# Move all currently playing audio streams to the new sink
pactl list sink-inputs | awk '/^Sink Input #/ {print $3}' | while read -r INPUT_ID; do
    pactl move-sink-input "$INPUT_ID" "$SINK_ID"
done

notify-send "Audio Switcher" "Switched audio output to sink $SINK_ID"