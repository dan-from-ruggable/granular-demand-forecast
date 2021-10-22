# Granular Demand Forecast

This repo contains code and documentation for the Granular Demand Forecast, which uses FB's Prophet package to create forecasts that take into account additional covariates.

* sql: Contains the sql files used by the model to pull the number of rug sales by overall, function + texture, and function + texture + size
* granular-demand-forecast-functions.R: defines helper functions used by gdf_v1.0
* gdf_v1.0.ipynb: notebook used to create forecasts and push to redshift
* pull_data_from_gsheets.ipynb: R script that pulls ad spend and marketing events from google sheets for use as covariates in the GDF

## How to use this
* Refer to step-by-step manual [here](https://docs.google.com/document/d/1n_rsjeCNAD4a9TJKX7XyxW-FWqiu47_ETlXFfGlo-DA/edit?usp=sharing)

## Reference Material
* [Quick start guide for prophet](https://facebook.github.io/prophet/docs/quick_start.html#python-api)

## Potential Improvements
* UI dashboard to create GDF outputs instead of notebook
* Automated way for checks instead of visual checks