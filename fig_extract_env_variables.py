#================================================================
# load libraries
#================================================================
import numpy as np
import pandas as pd
import xarray as xr
import geopandas as gpd
import matplotlib.pyplot as plt
from shapely.geometry import Polygon
from shapely.affinity import affine_transform

#================================================================
# convert nc to shapefile
#================================================================
##===============================================
## define function
##===============================================
def nc2shapefile(nc_file, variable_name, lat_name='latitude', lon_name='longitude'):
    # open nc file using xarray
    dataset = xr.open_dataset(nc_file)

    # extract the variable data
    variable_data = dataset[variable_name].isel(band=0).values

    # extract latitude and longitude bounds
    latitudes = dataset[lat_name].values
    longitudes = dataset[lon_name].values

    # create a list of polygons
    polygons = []
    values = []
    for i in range(len(latitudes) - 1):
        for j in range(len(longitudes) - 1):
            lat1 = latitudes[i]
            lat2 = latitudes[i + 1]
            lon1 = longitudes[j]
            lon2 = longitudes[j + 1]
            value = variable_data[i, j]
            if not np.isnan(value): # only include cells with valid data
                polygon = Polygon([(lon1, lat1), (lon1, lat2), (lon2, lat2), (lon2, lat1)])
                polygons.append(polygon)
                values.append(value)

    # return a geopandas dataframe
    gdf = gpd.GeoDataFrame({variable_name: values, 'geometry': polygons})
    return gdf

##===============================================
## apply function
##===============================================
nc = './data/grid_tmax_epsg_2163.nc'
variable_name = 'tmax'
lat_name = 'y'
lon_name = 'x'
gdf_tmax_grid = nc2shapefile(nc, variable_name, lat_name, lon_name)
gdf_tmax_grid.head()
gdf_tmax_grid.shape

#================================================================
# shear geopandas dataframe
#================================================================
gdf_cus = gpd.read_file('./data/county_cus.zip')
gdf_tmax_coun = gpd.read_file('./data/cus_tmax_epsg_2163.zip')

# sm = [1.5, 1, 0, 0.7, 0, 0]    # northeast stretched horizontally
sm = [1.3, -0.5, 0, 1.0, 0, 0] # northwest stretched horizontally
gdf_cus['geometry'] = gdf_cus['geometry'].apply(lambda geom: affine_transform(geom, sm))
gdf_tmax_coun['geometry'] = gdf_tmax_coun['geometry'].apply(lambda geom: affine_transform(geom, sm))
gdf_tmax_grid['geometry'] = gdf_tmax_grid['geometry'].apply(lambda geom: affine_transform(geom, sm))

#================================================================
# plot data
#================================================================
## county boundary
fig, ax = plt.subplots(figsize=(20, 20))
gdf_cus.boundary.plot(ax=ax, lw=0.5, edgecolor='black')
ax.axis('off')
fig.savefig('./results/stack_map_county_boundary.png', bbox_inches='tight', dpi=300)

## county temperature
fig, ax = plt.subplots(figsize=(20, 20))
gdf_tmax_coun.plot(ax=ax, column='tmax', edgecolor='black', lw=0.5, cmap='seismic')
ax.axis('off')
fig.savefig('./results/stack_map_tmax_county.png', bbox_inches='tight', dpi=300)

## grid temperature
fig, ax = plt.subplots(figsize=(20, 20))
gdf_tmax_grid.plot(ax=ax, column='tmax', facecolor='none', cmap='seismic', legend=False)
ax.axis('off')
fig.savefig('./results/stack_map_tmax_grid.png', bbox_inches='tight', dpi=300)

#======================================================================================
# combine figures
#======================================================================================
# open figures
img1  = Image.open('./results/stack_map_county_boundary.png')
img2  = Image.open('./results/stack_map_tmax_grid.png')
img3  = Image.open('./results/stack_map_tmax_county.png')

# 3x1 figure
fig, axes = plt.subplots(3, 1, figsize=(15, 15), gridspec_kw={'hspace': 0, 'wspace': 0})
fig.subplots_adjust(hspace=0.0, wspace=0.0)  # Reduce gaps between images

# display images
axes[0].imshow(img1); axes[0].axis('off'); axes[0].set_title('a)', loc='left', fontsize=18)
axes[1].imshow(img2); axes[1].axis('off'); axes[1].set_title('b)', loc='left', fontsize=18)
axes[2].imshow(img3); axes[2].axis('off'); axes[2].set_title('c)', loc='left', fontsize=18)

# save image
plt.tight_layout(pad=0, h_pad=0, w_pad=0)
plt.subplots_adjust(left=0, right=0.5, top=0.5, bottom=0)
fig.savefig('./results/combined.png', bbox_inches='tight', dpi=300)

#============================== END ==============================

