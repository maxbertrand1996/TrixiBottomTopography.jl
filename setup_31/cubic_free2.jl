###################################################################################################
# This script is used to verify that the well-balanced property is fulfilled when using cubic     #
# B-spline interpolation with free end condition over a data set which contains 25 data points    #
###################################################################################################

# Include packages
using TrixiBottomTopography
using Trixi
using OrdinaryDiffEq
using Downloads: download

# Downlowad data from gist
Rhine_data = download("https://gist.githubusercontent.com/maxbertrand1996/482ddf67451e2a8df647786d84ad06d4/raw/b3d4eea8a877ef27319baf9b062e1764bd2d535f/Appendix_Rhine_data_1D_40_x_100.txt")

# Define B-spline structure
spline_struct = CubicBSpline(Rhine_data)
# Define B-spline interpolation function
spline_func(x) = spline_interpolation(spline_struct, x)

equations = ShallowWaterEquations1D(gravity_constant=9.81, H0=60.0)

function initial_condition_well_balancedness(x, t, equations::ShallowWaterEquations1D)
  # Set the background values
  H = equations.H0
  v = 0.0

  b = spline_func(x[1])

  return prim2cons(SVector(H, v, b), equations)
end

initial_condition = initial_condition_well_balancedness

###############################################################################
# Get the DG approximation space

volume_flux = (flux_wintermeyer_etal, flux_nonconservative_wintermeyer_etal)
surface_flux = (flux_fjordholm_etal, flux_nonconservative_fjordholm_etal)
solver = DGSEM(polydeg=3, surface_flux=surface_flux,
               volume_integral=VolumeIntegralFluxDifferencing(volume_flux))

###############################################################################
# Get the TreeMesh and setup a periodic mesh

coordinates_min = spline_struct.x[1]
coordinates_max = spline_struct.x[end]
mesh = TreeMesh(coordinates_min, coordinates_max,
                initial_refinement_level=3,
                n_cells_max=10_000)

# Create the semi discretization object
semi = SemidiscretizationHyperbolic(mesh, equations, initial_condition, solver)

###############################################################################
# ODE solver

# To obtain the other results, this variable has to be adjusted
tspan = (0.0, 10.0)
ode = semidiscretize(semi, tspan)

###############################################################################
# Callbacks

summary_callback = SummaryCallback()

analysis_interval = 1000
analysis_callback = AnalysisCallback(semi, interval=analysis_interval,
                                     extra_analysis_integrals=(lake_at_rest_error,))

alive_callback = AliveCallback(analysis_interval=analysis_interval)

stepsize_callback = StepsizeCallback(cfl=1.0)

callbacks = CallbackSet(summary_callback, analysis_callback, alive_callback, 
                        stepsize_callback)

###############################################################################
# run the simulation

sol = solve(ode, CarpenterKennedy2N54(williamson_condition=false),
            dt=1.0, # solve needs some value here but it will be overwritten by the stepsize_callback
            save_everystep=false, callback=callbacks);
summary_callback() # print the timer summary