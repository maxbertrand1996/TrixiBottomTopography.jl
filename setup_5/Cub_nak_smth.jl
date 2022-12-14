###################################################################################################
# Plotting a cross section of the Rhine valley using the cubic B-spline functionality with        # 
# not-a-knot end condition and smoothing implemented in TrixiBottomTopography.jl                  #
###################################################################################################

# Include packages
using TrixiBottomTopography
using Plots
using Downloads: download

# Downlowad data from gist
Rhine_data = download("https://gist.githubusercontent.com/maxbertrand1996/19c33682b99bfb1cc3116f31dd49bdb9/raw/aa768f9b12c1df647066c063e8630ee5f9c179fb/Rhine_data_1D_40_x_841.txt")

# Define B-spline structure
cub_struct = CubicBSpline(Rhine_data; end_condition="not-a-knot", 
                            smoothing_factor=9999)
# Define B-spline interpolation function
cub_func(x) = spline_interpolation(cub_struct, x)

# Define interpolation points
n = 100
x_int_pts = Vector(LinRange(cub_struct.x[1], cub_struct.x[end], n))

# Get interpolated values
y_int_pts = cub_func.(x_int_pts)

# Plotting
pgfplotsx()
plot(x_int_pts, y_int_pts,
     xlabel="ETRS89 East", ylabel="DHHN2016 Height",
     label="Bottom topography", 
     title="Cubic B-spline interpolation with not-a-knot end 
            condition and smoothing")