#!/bin/sh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
polybar -l info mybar 2>&1 | tee -a /tmp/polybar.log & disown
sleep 0.1
polybar-msg cmd hide &

echo "Polybar launched..."
