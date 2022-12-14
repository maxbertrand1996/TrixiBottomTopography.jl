###################################################################################################
# Plotting a cross section of the Rhine valley using the linear B-spline functionality            # 
# implemented in TrixiBottomTopography.jl.                                                        #
###################################################################################################

# Include packages
using TrixiBottomTopography
using Plots
using Downloads: download

# Downlowad data from gist
Rhine_data = download("https://gist.githubusercontent.com/maxbertrand1996/19c33682b99bfb1cc3116f31dd49bdb9/raw/d96499a1ffe250bc8e4cca8622779bae61543fd8/Rhine_data_1D_40_x_841.txt")

# Define B-spline structure
lin_struct = LinearBSpline(Rhine_data)
# Define B-spline interpolation function
lin_func(x) = spline_interpolation(lin_struct, x)

# Define interpolation points
n = 100
x_int_pts = Vector(LinRange(lin_struct.x[1], lin_struct.x[end], n))

# Get interpolated values
y_int_pts = lin_func.(x_int_pts)

# Plotting
pgfplotsx()
plot(x_int_pts, y_int_pts, xlabel="ETRS89 East", ylabel="DHHN2016 Height",
     label="Bottom topography", title="Linear B-spline interpolation")