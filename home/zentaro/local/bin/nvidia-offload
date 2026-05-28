#!/bin/sh

export __EGL_VENDOR_LIBRARY_FILENAMES='/usr/share/glvnd/egl_vendor.d/10_nvidia.json'
export VK_ICD_FILENAMES='/usr/share/vulkan/icd.d/nvidia_icd.json'
export LIBVA_DRIVER_NAME='nvidia'
export __GLX_VENDOR_LIBRARY_NAME='nvidia'
export __VK_LAYER_NV_optimus='NVIDIA_only'
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER='NVIDIA-G0'
export __NV_PRIME_RENDER_OFFLOAD=1

exec "$@"
