#!/bin/bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}=== NVIDIA Driver Detection Script ===${NC}"
echo

NVIDIA_GPU=$(lspci -k -d ::03xx 2>/dev/null)

if [ -z "$NVIDIA_GPU" ]; then
    echo -e "${YELLOW}No NVIDIA GPU detected.${NC}"
    echo "If you believe this is an error, check manually with: lspci -k -d ::03xx"
    exit 0
fi

echo -e "${GREEN}Detected NVIDIA GPU:${NC}"
echo "$NVIDIA_GPU"
echo

GPU_ID=$(echo "$NVIDIA_GPU" | grep -oP '\[.+?\]' | head -1)
GPU_NAME=$(echo "$NVIDIA_GPU" | grep -oP 'NVIDIA Corporation \K[^[]+')

echo -e "${CYAN}GPU Model: ${NC}${GPU_ID:-N/A}"
echo -e "${CYAN}GPU Chip: ${NC}${GPU_NAME:-N/A}"
echo

DRIVER_PACKAGES=()
ADDITIONAL_PACKAGES=()
KERNEL_PARAMS=""
MKINITCPIO_HOOKS=""
AUR_HELPER_NEEDED=false

GPU_STRING="${NVIDIA_GPU,,}"

detect_driver() {
    local gpu="$1"

    if echo "$gpu" | grep -qiE 'gb[0-9]|blackwell'; then
        echo "nvidia-open (official)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'ga[0-9]|amper|ampere|geforce.*rtx 30|geforce.*rtx 40|geforce.*rtx 50'; then
        echo "nvidia-open (official)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'ad[0-9]|geforce.*rtx 40|geforce.*rtx 50'; then
        echo "nvidia-open (official)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'tu[0-9]|geforce.*rtx 20|geforce.*gtx 16|geforce.*gtx 1650|geforce.*gtx 1660'; then
        echo "nvidia-open (official) or nvidia-580xx-dkms (AUR)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'gp[0-9]|pascal|geforce.*gtx 1060|geforce.*gtx 1050|geforce.*gtx 1070|geforce.*gtx 1080'; then
        echo "nvidia-580xx-dkms (AUR)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'gm[0-9]|gv[0-9]|maxwell|volta|geforce.*gtx 9|geforce.*gtx 750|geforce.*gtx 970|geforce.*gtx 980'; then
        echo "nvidia-580xx-dkms (AUR)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'gk[0-9]|kepler|geforce.*gtx 6|geforce.*gtx 7|geforce.*gtx 680|geforce.*gtx 770'; then
        echo "nvidia-470xx-dkms (AUR)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'gf[0-9]|fermi|geforce.*gtx 4|geforce.*gtx 5'; then
        echo "nvidia-390xx-dkms (AUR)"
        return 0
    fi

    if echo "$gpu" | grep -qiE 'nv5[0-9]|g80|g90|gt2|tesla|geforce.*6|geforce.*7'; then
        echo "nvidia-340xx-dkms (AUR)"
        return 0
    fi

    echo "nvidia-open (official) - manual verification recommended"
}

NVIDIA_PKG=$(detect_driver "$GPU_STRING")

echo -e "${CYAN}=== Driver Analysis ===${NC}"
echo

if [[ "$NVIDIA_PKG" == *"dkms"* ]]; then
    AUR_HELPER_NEEDED=true
    echo -e "${YELLOW}Note: $NVIDIA_PKG is an AUR package${NC}"
    echo "You will need an AUR helper (yay/paru) installed."
    echo

    if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
        echo -e "${RED}ERROR: No AUR helper found. Install yay or paru first.${NC}"
        echo "Or add base-devel and use makepkg manually."
    fi
    echo
fi

echo -e "${GREEN}Recommended driver package: ${CYAN}$NVIDIA_PKG${NC}"
echo

MULTILIB_ENABLED=$(grep -q "^\[multilib\]" /etc/pacman.conf 2>/dev/null && echo "yes" || echo "no")

if [[ "$NVIDIA_PKG" == *"nvidia-open"* ]]; then
    ADDITIONAL_PACKAGES+=("lib32-nvidia-open-utils")
elif [[ "$NVIDIA_PKG" == *"dkms"* ]] || [[ "$NVIDIA_PKG" == *"official"* ]]; then
    ADDITIONAL_PACKAGES+=("lib32-nvidia-utils")
fi

echo -e "${CYAN}=== Recommendations ===${NC}"
echo

if [[ "$NVIDIA_PKG" == *"AUR"* ]]; then
    echo -e "${YELLOW}0. AUR HELPER REQUIRED (install first in chroot):${NC}"
    echo "   # Install yay or paru before installing AUR packages"
    echo "   pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    echo
fi

echo -e "${YELLOW}1. PACSTRAP COMMAND (add to 1-init.sh pacstrap):${NC}"
if [[ "$NVIDIA_PKG" == *"nvidia-open"* ]]; then
    echo "   pacstrap -K /mnt ... nvidia-open ${ADDITIONAL_PACKAGES[*]}"
elif [[ "$NVIDIA_PKG" == *"official"* ]]; then
    echo "   pacstrap -K /mnt ... nvidia-open ${ADDITIONAL_PACKAGES[*]}"
else
    echo "   pacstrap -K /mnt ... ${NVIDIA_PKG%% (*} ${ADDITIONAL_PACKAGES[*]}"
fi
echo

if [ "$MULTILIB_ENABLED" != "yes" ]; then
    echo -e "${YELLOW}2. ENABLE MULTILIB (add to pacman.conf before installing):${NC}"
    echo "   # Add to /etc/pacman.conf:"
    echo "   [multilib]"
    echo "   Include = /etc/pacman.d/mirrorlist"
else
    echo -e "${GREEN}2. MULTILIB:${NC} Already enabled"
fi
echo

echo -e "${YELLOW}3. KERNEL PARAMETERS (add to GRUB_CMDLINE_LINUX in /etc/default/grub):${NC}"
echo "   nvidia-drm.modeset=1"
echo

echo -e "${YELLOW}4. MKINITCPIO (usually unchanged):${NC}"
echo "   # HOOKS typically already contain 'mod' which loads nvidia modules"
echo "   # For early loading (Wayland), add to /etc/mkinitcpio.conf MODULES:"
echo "   MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)"
echo "   # Then run: mkinitcpio -P"
echo

echo -e "${YELLOW}5. GRUB REGENERATION (add to 4-bootloader.sh or run after):${NC}"
echo "   grub-mkconfig -o /boot/grub/grub.cfg"
echo

echo -e "${YELLOW}6. OPTIONAL - Wayland/Xorg:${NC}"
echo "   # Wayland: Should work with nvidia-drm.modeset=1"
echo "   # Xorg: Auto-configures, no xorg.conf needed"
echo

echo -e "${CYAN}====================================${NC}"
echo -e "${CYAN}=== SUMMARY FOR AUTOMATED SETUP ===${NC}"
echo -e "${CYAN}====================================${NC}"
echo

echo -e "${GREEN}pacstrap packages:${NC}"
if [[ "$NVIDIA_PKG" == *"nvidia-open"* ]]; then
    echo "  nvidia-open lib32-nvidia-open-utils"
elif [[ "$NVIDIA_PKG" == *"official"* ]]; then
    echo "  nvidia-open lib32-nvidia-open-utils"
else
    echo "  ${NVIDIA_PKG%% (*} lib32-nvidia-utils"
fi
echo

echo -e "${GREEN}/etc/default/grub modification:${NC}"
echo '  GRUB_CMDLINE_LINUX="... nvidia-drm.modeset=1"'
echo

echo -e "${GREEN}Commands to run in chroot:${NC}"
echo "  mkinitcpio -P"
echo "  grub-mkconfig -o /boot/grub/grub.cfg"
echo

echo -e "${GREEN}Files created/modified:${NC}"
echo "  /etc/mkinitcpio.conf (if early NVIDIA modules needed)"
echo "  /etc/default/grub"
echo "  /boot/grub/grub.cfg (regenerated)"
echo

if [[ "$NVIDIA_PKG" == *"AUR"* ]]; then
    echo -e "${RED}IMPORTANT: This GPU requires an AUR package!${NC}"
    echo "Install yay/paru in chroot first."
fi

echo
echo -e "${CYAN}=== Detection Complete ===${NC}"
