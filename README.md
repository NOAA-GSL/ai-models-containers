
# ai-models-containers

(In development) A collection of Dockerfiles to build containers for running [ECMWF ai-models](https://github.com/ecmwf-lab/ai-models)

## Notes

* Requires [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-container-toolkit) to build for GPU support
* Current containers built for CUDA Version 12.3.  You may need to modify source image to match CUDA version to your GPU supported version (i.e 12.3, 12.4, etc..)

## Build container for FourCastNet and PanguWeather

```
docker build --rm --pull -t ai-models - < Dockerfile.ai-models
```

## Build container for Graphcast

```
docker build --rm --pull -t ai-models-graphcast - < Dockerfile.ai-models-gc
```

## Example running FourCastNet using ECMWF CDS for datasource:

*(modify paths to assets, outputs, and cdsapirc file to your environment)*
```
docker run --rm -it -e AI_MODELS_ASSETS=/assets/ -v /home/user/ai-models/assets/:/assets -v /home/user/ai-models/output/:/output -v /home/user/.cdsapirc:/root/.cdsapirc --gpus all ai-models:latest ai-models --download-assets --input cds --assets-sub-directory --date 20240713 --path /output/output-{step}.grb fourcastnetv2-small

```

## To Do

- [ ] Add GFS input

## Disclaimer

This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an “as is” basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercia products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.
