###################################################################################################
# Script used to simulate a dam break problem over a B-spline interpolated section of the         #
# Rhine river valley                                                                              #
###################################################################################################

using TrixiBottomTopography
using LinearAlgebra
using OrdinaryDiffEq
using Trixi

# Download two dimensional Rhine bottom data from a gist
Rhine_data = download("https://gist.githubusercontent.com/maxbertrand1996/9c8534441afc2f2f9130963e876334ab/raw/c58bf43608c876be0bb9d9014b86ec6d584722f2/Appendix_Rhine_data_2D_40.txt")

# B-spline interpolation of the underlying data
spline_struct = BicubicBSpline(Rhine_data)
spline_func(x,y) = spline_interpolation(spline_struct, x, y)

equations = ShallowWaterEquations2D(gravity_constant=9.81, H0=55.0)

function initial_condition_wave(x, t, equations::ShallowWaterEquations2D)

  inicenter = SVector(357480.0, 5642519.0)
  x_norm = x - inicenter
  r = norm(x_norm)

  # Calculate primitive variables
  H =  r < 50 ? 65.0 : 55.0
  v1 = 0.0
  v2 = 0.0

  x1, x2 = x
  b = spline_func(x1, x2)

  return prim2cons(SVector(H, v1, v2, b), equations)
end

initial_condition = initial_condition_wave

###############################################################################
# Get the DG approximation space

volume_flux = (flux_wintermeyer_etal, flux_nonconservative_wintermeyer_etal)
surface_flux = (FluxHydrostaticReconstruction(flux_lax_friedrichs, hydrostatic_reconstruction_audusse_etal),
                flux_nonconservative_audusse_etal)
basis = LobattoLegendreBasis(4)

indicator_sc = IndicatorHennemannGassner(equations, basis,
                                         alpha_max=0.5,
                                         alpha_min=0.001,
                                         alpha_smooth=true,
                                         variable=waterheight_pressure)
volume_integral = VolumeIntegralShockCapturingHG(indicator_sc;
                                                 volume_flux_dg=volume_flux,
                                                 volume_flux_fv=surface_flux)

solver = DGSEM(basis, surface_flux, volume_integral)

###############################################################################
# Get the TreeMesh and setup a periodic mesh

coordinates_min = (spline_struct.x[1], spline_struct.y[1])
coordinates_max = (spline_struct.x[end], spline_struct.y[end])

cells_per_dimension = (16, 16)

mesh = StructuredMesh(cells_per_dimension, coordinates_min, coordinates_max)


# create the semi discretization object
semi = SemidiscretizationHyperbolic(mesh, equations, initial_condition, solver)

###############################################################################
# ODE solvers, callbacks etc.

tspan = (0.0, 25.0)
ode = semidiscretize(semi, tspan)

###############################################################################
# Callbacks
save_solution = SaveSolutionCallback(; interval=20,
                                     save_initial_solution=true,
                                     save_final_solution=true,
                                     output_directory="setup_34/out")

callbacks = CallbackSet(save_solution)

###############################################################################
# run the simulation

# use a Runge-Kutta method with automatic (error based) time step size control
sol = solve(ode, RDPK3SpFSAL49(), abstol=1.0e-8, reltol=1.0e-8, save_everystep=true, 
            callback=callbacks);