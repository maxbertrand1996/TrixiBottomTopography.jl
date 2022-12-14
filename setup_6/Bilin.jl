###################################################################################################
# Plotting a section of the Rhine valley using the bilinear B-spline functionality implemented in #
# TrixiBottomTopography.jl                                                                        #
###################################################################################################

# Include packages
using TrixiBottomTopography
using Plots
using Downloads: download

# Helperfunction to fill the solution matrix
# Input parameters:
#  - f: spline function
#  - x: vector of x values
#  - y: vector of y values
function fill_sol_mat(f, x, y)
    
  # Get dimensions for solution matrix
  n = length(x)
  m = length(y)

  # Create empty solution matrix
  z = zeros(n,m)

  # Fill solution matrix
  for i in 1:n, j in 1:m
    # Evaluate spline functions at given x,y values
    z[j,i] = f(x[i], y[j])
  end

  # Return solution matrix
  return z
end

# Downlowad data from gist
Rhine_data = download("https://gist.githubusercontent.com/maxbertrand1996/a30db4dc9f5427c78160321d75a08166/raw/9a9a1e90eb98ee7a57e22bceb00e23f4c7d084f6/Rhine_data_2D_40.txt")

# Define B-spline structure
bilin_struct = BilinearBSpline(Rhine_data)
# Define B-spline interpolation function
bilin_func(x,y) = spline_interpolation(bilin_struct, x, y)

# Define interpolation points
n = 100
x_int_pts = Vector(LinRange(bilin_struct.x[1], bilin_struct.x[end], n))
y_int_pts = Vector(LinRange(bilin_struct.y[1], bilin_struct.y[end], n))

# Get interpolated matrix
z_int_pts = fill_sol_mat(bilin_func, x_int_pts, y_int_pts)

# Plotting
pgfplotsx()
plot(x_int_pts, y_int_pts, z_int_pts, st =:surface, camera=(-30,30),
     xlabel="ETRS89 East", ylabel="ETRS89 North", zlabel="DHHN2016 Height",
     label="Bottom topography", title="Bilinear B-spline interpolation")