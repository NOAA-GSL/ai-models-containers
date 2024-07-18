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
        apt install -y python3 python3-pip \
                       libexpat1 libglib2.0-0 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* 

# Force GPU Runtime with env variable
ENV ONNXRUNTIME=onnxruntime-gpu
RUN pip3 --no-cache-dir install \
        torch onnxruntime-gpu ai-models ai-models-panguweather \
        ai-models-fourcastnet ai-models-fourcastnetv2 zarr \
        ai-models-gfs==0.0.8 
