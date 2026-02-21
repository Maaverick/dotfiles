#!/bin/bash
# ~/.config/hypr/lock.sh
# Enhanced lock script with audio mute, brightness control, and notifications

# Mute audio before locking
wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 2>/dev/null || pactl set-sink-mute @DEFAULT_SINK@ 1

# Dismiss notifications (if using notification daemon)
killall mako 2>/dev/null || killall dunst 2>/dev/null || true

# Start hyprlock
hyprlock "$@"
