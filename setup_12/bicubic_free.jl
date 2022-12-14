###################################################################################################
# This script is used to verify that the well-balanced property is fulfilled when using bicubic   #
# B-spline interpolation with free end condition over a data set which contains 625 data points   #
###################################################################################################

# Include packages
using TrixiBottomTopography
using OrdinaryDiffEq
using Trixi
using Downloads: download

# Downlowad data from gist
Rhine_data = download("https://gist.githubusercontent.com/maxbertrand1996/a30db4dc9f5427c78160321d75a08166/raw/9a9a1e90eb98ee7a57e22bceb00e23f4c7d084f6/Rhine_data_2D_40.txt")

# Define B-spline structure
spline_struct = BicubicBSpline(Rhine_data)
# Define B-spline interpolation function
spline_func(x,y) = spline_interpolation(spline_struct, x, y)

equations = ShallowWaterEquations2D(gravity_constant=9.81, H0=60.0)

function initial_condition_well_balancedness(x, t, equations::ShallowWaterEquations2D)
  # Set the background values
  H = equations.H0
  v1 = 0.0
  v2 = 0.0

  x1, x2 = x
  b = spline_func(x1, x2)
  
  return prim2cons(SVector(H, v1, v2, b), equations)
end

initial_condition = initial_condition_well_balancedness

  ###############################################################################
# Get the DG approximation space

volume_flux = (flux_wintermeyer_etal, flux_nonconservative_wintermeyer_etal)
solver = DGSEM(polydeg=3, surface_flux=(flux_fjordholm_etal, flux_nonconservative_fjordholm_etal),
               volume_integral=VolumeIntegralFluxDifferencing(volume_flux))

###############################################################################
# Get the TreeMesh and setup a periodic mesh

coordinates_min = (spline_struct.x[1], spline_struct.y[1])
coordinates_max = (spline_struct.x[end], spline_struct.y[end])
mesh = TreeMesh(coordinates_min, coordinates_max,
                initial_refinement_level=3,
                n_cells_max=10_000)

# Create the semi discretization object
semi = SemidiscretizationHyperbolic(mesh, equations, initial_condition, solver)

###############################################################################
# ODE solver

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