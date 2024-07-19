# -*- coding: utf-8 -*-
#
# @Author: Jebb Q. Stewart
# @Date:   2023-10-06
# @Email: jebb.q.stewart@noaa.gov 
#
# @Last modified by:   Jebb Q. Stewart
# @Last Modified time: 2024-07-18

# Requires NVIDIA Container Toolkit to build for GPU support
# https://github.com/NVIDIA/nvidia-container-toolkit

# Match CUDA version to your GPU supported version (i.e 12.3, 12.4, etc..)
FROM nvcr.io/nvidia/cuda:12.3.1-runtime-ubuntu22.04

LABEL maintainer="Jebb Q Stewart <jebb.q.stewart@noaa.gov>"

# eccodes installed as part of ai-models below requires expat and glib2
# versions may change as ubuntu changes
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive\
        apt install -y python3 python3-pip git \
                       libexpat1 libglib2.0-0 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* 

# Note, graphcast is not compatible with numpy>=2 or jax>=0.4.24
#       need to match cuda runtime to cuda source image
RUN pip3 --no-cache-dir install --upgrade \
         ai-models-gfs==0.0.8 ai-models-graphcast-gfs==0.0.7 \
         geopy numpy==1.26.4 nvidia-cuda-runtime-cu12==12.3.101 \
         git+https://github.com/deepmind/graphcast.git \
         "jax[cuda12]<0.4.24"

