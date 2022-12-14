# Simulations

Code from [maxbertrand1996/TrixiBottomTopography.jl branch ma_bertrand_2022](https://github.com/maxbertrand1996/TrixiBottomTopography.jl/tree/ma_bertrand_2022)

Commit: fe788f5

***
## Systmen information

Julia Version 1.8.3

Commit 0434deb161 (2022-11-14 20:14 UTC)

Platform Info:
- OS: Windows (x86_64-w64-mingw32)
- CPU: 8 × Intel(R) Core(TM) i5-1035G4 CPU @ 1.10GHz
- WORD_SIZE: 64
- LIBM: libopenlibm
- LLVM: libLLVM-13.0.1 (ORCJIT, icelake-client)
- Threads: 1 on 8 virtual cores
***

# General
This folder contains a clone of the repository [maxbertrand1996/TrixiBottomTopography.jl](https://github.com/maxbertrand1996/TrixiBottomTopography.jl/tree/main). For our purpose, we will only consider the branch `ma_bertrand_2022`. Additionally, this folder contains `setup` folders which contain the setup for the different simulations which have been used to otbain the results throughout the thesis

To run the simulations, navigate to this folder (`simulations`) on the console and type in the following command to start `Julia` and make use of the package `TrixiBottomTopogrpahy.jl` implemented in this repository:
```
julia --project=@.
```

# Setup information
In the following, we will list all the different setups for the simulations and include the execution commands to call the setup files.

## setup_1
This setup produces the linear B-spline interpolation of the Rhine river cross-section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_1\\lin.jl")
```
The resulting file has been used in Figure 8.1 of this thesis.

## setup_2
This setup produces the cubic B-spline interpolation with free end condition of the Rhine river cross-section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_2\\Cub_free.jl")
```
The resulting file has been used in Figure 8.2 of this thesis.

## setup_3
This setup produces the cubic B-spline interpolation with not-a-knot end condition of the Rhine river cross-section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_3\\Cub_nak.jl")
```
The resulting file has been used in Figure 8.3 of this thesis.

## setup_4
This setup produces the cubic B-spline interpolation with free end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river cross-section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_4\\Cub_free_smth.jl")
```
The resulting file has been used in Figure 8.4 of this thesis.

## setup_5
This setup produces the cubic B-spline interpolation with not-a-knot end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river cross-section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_5\\Cub_nak_smth.jl")
```
The resulting file has been used in Figure 8.5 of this thesis.

## setup_6
This setup produces the bilinear B-spline interpolation of the Rhine river section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_6\\Bilin.jl")
```
The resulting file has been used in Figure 8.6 of this thesis.

## setup_7
This setup produces the bicubic B-spline interpolation with free end condition of the Rhine river section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_7\\Bic_free.jl")
```
The resulting file has been used in Figure 8.7 of this thesis.

## setup_8
This setup produces the bicubic B-spline interpolation with not-a-knot end condition of the Rhine river section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_8\\Bic_nak.jl")
```
The resulting file has been used in Figure 8.8 of this thesis.

## setup_9
This setup produces the bicubic B-spline interpolation with free end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_9\\Bic_free_smth.jl")
```
The resulting file has been used in Figure 8.9 of this thesis.

## setup_10
This setup produces the cubic B-spline interpolation with not-a-knot end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river section introduced in Chapter 8.1 of the thesis.
```julia
include("setup_10\\Bic_nak_smth.jl")
```
The resulting file has been used in Figure 8.10 of this thesis.

## setup_11
The files in this setup are used to verify that the well-balanced property is fulfilled when working with B-spline interpolated bottom topographies. In this case, we are interested in the one dimensional case. Therefore the files 
- `linear.jl`
- `cubic_free.jl`
- `cubic_n-a-k.jl`

are implemented in this folder.
These files determine the lake-at-rest error for a lake-at-rest problem when using linear and cubic B-spline interpolated bottom topographies with free and not-a-knot end condition. The underlying data is the same cross-section data as introduced in Section 8.1 of the thesis.

The implemented files run a simulation of the time interval `tspan = [0.0, 10.0]`. To run the simulations, execute:
```julia
include("setup_11\\linear.jl")
include("setup_11\\cubic_free.jl")
include("setup_11\\cubic_n-a-k.jl")
```

Because we need the results of more time intervals than just `tspan = [0.0, 10.0]`, we have to perform the following steps afterwards to obtain all the necessary data:

1. Change `tspan` to `tspan = [0.0, 100.0]` for all the files and re-run the simulations as described above
2. Change `tspan` to `tspan = [0.0, 1000.0]` for all the files and re-run the simulations
3. Change `tspan` to `tspan = [0.0, 10000.0]` for all the files and re-run the simulations

The obtained errors can be found in Table 8.1 of this thesis.

## setup_12
The files in this setup are used to verify that the well-balanced property is fulfilled when working with B-spline interpolated bottom topographies. In this case we are interested in the two dimensional case. Therefore the files 
- `bilinear.jl`
- `bicubic_free.jl`
- `bicubic_n-a-k.jl`

are implemented in this folder.
These files determine the lake-at-rest error for a lake-at-rest problem when using bilinear and bicubic B-spline interpolated bottom topographies with free and not-a-knot end condition. The underlying data is the same Rhine section data as introduced in Section 8.1 of the thesis.

The implemented files run a simulation of the time interval `tspan = [0.0, 10.0]`. To run the simulations, execute:
```julia
include("setup_12\\bilinear.jl")
include("setup_12\\bicubic_free.jl")
include("setup_12\\bicubic_n-a-k.jl")
```

Because we need the results of more time intervals than just `tspan = [0.0, 10.0]`, we have to perform the following steps afterwards, to obtain all the necessary data:

1. Change `tspan` to `tspan = [0.0, 100.0]` for all the files and re-run the simulations as described above
2. Change `tspan` to `tspan = [0.0, 1000.0]` for all the files and re-run the simulations
3. Change `tspan` to `tspan = [0.0, 10000.0]` for all the files and re-run the simulations

The obtained errors can be found in Table 8.2 of this thesis.

## setup_13
The file in this folder is used to investigate if we get similar results in terms of EOC when using a linear B-spline interpolated bottom topography for a different number of fit knots compared to elixir [examples/tree_1d_dgsem/elixir_shallowwater_source_terms.jl](https://github.com/trixi-framework/Trixi.jl/blob/main/examples/tree_1d_dgsem/elixir_shallowwater_source_terms.jl) implemented in Trixi.jl.
Therefore execute
```julia
using Trixi

convergence_test("setup_13\\swe_source_terms_lin.jl", 4)
```
The implemented file uses 4 fit knots. To obtain the results for different numbers of fit knots, do the following
1. Set variable `n` (there is a comment in the code highlighting the variable) to `7` and re-run the simulation as described above (**Note:** This time, we do not need to include `using Trixi`)
2. Set variable `n = 10` and re-run the simulation
3. Set variable `n = 20` and re-run the simulation
4. Set variable `n = 50` and re-run the simulation
5. Set variable `n = 100` and re-run the simulation

The results can be found in Tables 8.3, B.5 and B.6 of this thesis.

## setup_14
The file in this folder is used to investigate if we get similar results in terms of EOC when using a cubic B-spline interpolated bottom topography with the free end condition for a different number of fit knots compared to elixir [examples/tree_1d_dgsem/elixir_shallowwater_source_terms.jl](https://github.com/trixi-framework/Trixi.jl/blob/main/examples/tree_1d_dgsem/elixir_shallowwater_source_terms.jl) implemented in Trixi.jl.
Therefore execute
```julia
using Trixi

convergence_test("setup_14\\swe_source_terms_cub-free.jl", 4)
```
The implemented file uses 4 fit knots. To obtain the results for different numbers of fit knots, do the following
1. Set variable `n` (there is a comment in the code highlighting the variable) to `7` and re-run the simulation as described above (**Note:** This time, we do not need to include `using Trixi`)
2. Set variable `n = 10` and re-run the simulation
3. Set variable `n = 20` and re-run the simulation
4. Set variable `n = 50` and re-run the simulation
5. Set variable `n = 100` and re-run the simulation

The results can be found in Tables 8.4, B.7 and B.8 of this thesis.

## setup_15
The file in this folder is used to investigate if we get similar results in terms of EOC when using a cubic B-spline interpolated bottom topography with the not-a-knot end condition for a different number of fit knots compared to elixir [examples/tree_1d_dgsem/elixir_shallowwater_source_terms.jl](https://github.com/trixi-framework/Trixi.jl/blob/main/examples/tree_1d_dgsem/elixir_shallowwater_source_terms.jl) implemented in Trixi.jl.
Therefore execute
```julia
using Trixi

convergence_test("setup_15\\swe_source_terms_cub-nak.jl", 4)
```
The implemented file uses 4 fit knots. To obtain the results for different numbers of fit knots, do the following
1. Set variable `n` (there is a comment in the code highlighting the variable) to `7` and re-run the simulation as described above (**Note:** This time, we do not need to include `using Trixi`)
2. Set variable `n = 10` and re-run the simulation
3. Set variable `n = 20` and re-run the simulation
4. Set variable `n = 50` and re-run the simulation
5. Set variable `n = 100` and re-run the simulation

The results can be found in Tables 8.5, B.9 and B.10 of this thesis.

## setup_16
The file in this folder is used to investigate if we get similar results in terms of EOC when using a bilinear B-spline interpolated bottom topography for a different number of fit knots in each dimension compared to elixir [examples/tree_2d_dgsem/elixir_shallowwater_source_terms.jl](https://github.com/trixi-framework/Trixi.jl/blob/main/examples/tree_2d_dgsem/elixir_shallowwater_source_terms.jl) implemented in Trixi.jl.
Therefore execute
```julia
using Trixi

convergence_test("setup_16\\swe_source_terms_bilin.jl", 4)
```
The implemented file uses 4 fit knots in each dimension. To obtain the results for different numbers of fit knots in each dimension, do the following
1. Set variable `n` (there is a comment in the code highlighting the variable) to `7` and re-run the simulation as described above (**Note:** This time, we do not need to include `using Trixi`)
2. Set variable `n = 10` and re-run the simulation
3. Set variable `n = 20` and re-run the simulation
4. Set variable `n = 50` and re-run the simulation
5. Set variable `n = 100` and re-run the simulation

The results can be found in Tables 8.6, B.11 and B.12 of this thesis.

## setup_17
The file in this folder is used to investigate if we get similar results in terms of EOC when using a bicubic B-spline interpolated bottom topography with free end condition for a different number of fit knots in each dimension compared to elixir [examples/tree_2d_dgsem/elixir_shallowwater_source_terms.jl](https://github.com/trixi-framework/Trixi.jl/blob/main/examples/tree_2d_dgsem/elixir_shallowwater_source_terms.jl) implemented in Trixi.jl.
Therefore execute
```julia
using Trixi

convergence_test("setup_17\\swe_source_terms_bicub-free.jl", 4)
```
The implemented file uses 4 fit knots in each dimension. To obtain the results for different numbers of fit knots in each dimension, do the following
1. Set variable `n` (there is a comment in the code highlighting the variable) to `7` and re-run the simulation as described above (**Note:** This time, we do not need to include `using Trixi`)
2. Set variable `n = 10` and re-run the simulation
3. Set variable `n = 20` and re-run the simulation
4. Set variable `n = 50` and re-run the simulation
5. Set variable `n = 100` and re-run the simulation

The results can be found in Tables 8.7, B.13 and B.14 of this thesis.

## setup_18
The file in this folder is used to investigate if we get similar results in terms of EOC when using a bicubic B-spline interpolated bottom topography with not-a-knot end condition for a different number of fit knots in each dimension compared to elixir [examples/tree_2d_dgsem/elixir_shallowwater_source_terms.jl](https://github.com/trixi-framework/Trixi.jl/blob/main/examples/tree_2d_dgsem/elixir_shallowwater_source_terms.jl) implemented in Trixi.jl.
Therefore execute
```julia
using Trixi

convergence_test("setup_18\\swe_source_terms_bicub-nak.jl", 4)
```
The implemented file uses 4 fit knots in each dimension. To obtain the results for different numbers of fit knots in each dimension, do the following
1. Set variable `n` (there is a comment in the code highlighting the variable) to `7` and re-run the simulation as described above (**Note:** This time, we do not need to include `using Trixi`)
2. Set variable `n = 10` and re-run the simulation
3. Set variable `n = 20` and re-run the simulation
4. Set variable `n = 50` and re-run the simulation
5. Set variable `n = 100` and re-run the simulation

The results can be found in Tables 8.8, B.15 and B.16 of this thesis.

## setup_19
The file in this folder simulates a one dimensional dam break problem where the cross-section of the Rhine river valley introduced in Chapter 8.1 has been used as the underlying data for the bottom topography.
At the end of the simulation, a plot is given of the state of the problem at the specified time point in `tspan[2]`.
To start the simulation, execute
```julia
include("setup_19\\dam_1d.jl")
```
This gives the plot used in Figure 8.11. This file can also be used to obtain the plots of Figures 8.12-8.15.
To do so, set:
- For Figure 8.12: `tspan = (0.0, 3.0)`
- For Figure 8.13: `tspan = (0.0, 7.0)`
- For Figure 8.14: `tspan = (0.0, 13.0)`
- For Figure 8.15: `tspan = (0.0, 21.0)`

and execute the same command as above. 

## setup_20
The file in this folder simulates a two dimensional dam break problem where the section of the Rhine river valley introduced in Chapter 8.1 has been used as the underlying data for the bottom topography.
To start the simulation, execute
```julia
include("setup_20\\2d_dam_break_Ch_8.jl")
```
This will produce `.h5` files for different steps of the simulations and save them in the `out` subfolder of this folder. These files then have to be converted into `.vtu` files. To do so, execute:
```julia
using Trixi2Vtk

trixi2vtk("setup_20/out/solution_*.h5", output_directory="setup_20/out", nvisnodes=15)
``` 
The `.vtu` files will be saved in the `out` subfolder. To obtain the plots as in Figures 8.16-8.20, we need to open ParaView and do the following steps:

**For the bottom topography**

1. Load `solution_*.vtu` from the `out` subfolder and select `b` → `Apply`
2. Select Filter `Extract Surface` → `Apply`
3. Select Filter `Linear Extrusion` → `Apply`
4. Select Filter `Elevation`, under `Properties` select the button `Z Axis` → `Apply`
5. Select Filter `Calculator`, under `Properties`, set `Results Array Name` to **bottom** and enter the function $floor(Elevation)*(b*20-750)$ → `Apply`
6. Select Filter `Wrap by Scalar` → `Apply`
7. Under `WrapByScalar1` go to `coloring` and click on `Edit`. There select `Interpret Values As Categories` and select under `Color Mapping Parameters` the colour `HTML: #555500` → `Render Views`

**For the water surface**

1. Load `solution_*.vtu` from the `out` subfolder and select `H` and `b` → `Apply`
2. Select Filter `Extract Surface` → `Apply`
3. Select Filter `Linear Extrusion` → `Apply`
4. Select Filter `Elevation`, under `Properties` select the button `Z Axis` → `Apply`
5. Select Filter `Calculator`, under `Properties`, set `Results Array Name` to **water** and enter the function $floor(Elevation)*((H-b)*20)+(b*20-750)$ → `Apply`
6. Select Filter `Wrap by Scalar` → `Apply`
7. Under `WrapByScalar2` go to `coloring` and click on `Edit`. There select `Interpret Values As Categories` and select under `Color Mapping Parameters` the colour `HTML: ##00aaff` and set `Nan Opacity` to `0.5`→ `Render Views`

The following `Time` values represent the snapshots for Figures 8.16-8.20

- Figure 8.16: `0`
- Figure 8.17: `13`
- Figure 8.18: `20`
- Figure 8.19: `35`
- Figure 8.20: `52`

## setup_21
This setup produces the linear B-spline interpolation of the Rhine river cross-section introduced in Chapter C.1 of the thesis.
```julia
include("setup_21\\lin2.jl")
```
The resulting file has been used in Figure C.2 of this thesis.

## setup_22
This setup produces the cubic B-spline interpolation with free end condition of the Rhine river cross-section introduced in Chapter C.1 of the thesis.
```julia
include("setup_22\\Cub_free2.jl")
```
The resulting file has been used in Figure C.3 of this thesis.

## setup_23
This setup produces the cubic B-spline interpolation with not-a-knot end condition of the Rhine river cross-section introduced in Chapter C.1 of the thesis.
```julia
include("setup_23\\Cub_nak2.jl")
```
The resulting file has been used in Figure C.4 of this thesis.

## setup_24
This setup produces the cubic B-spline interpolation with free end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river cross-section introduced in Chapter C.1 of the thesis.
```julia
include("setup_24\\Cub_free_smth2.jl")
```
The resulting file has been used in Figure C.5 of this thesis.

## setup_25
This setup produces the cubic B-spline interpolation with not-a-knot end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river cross-section introduced in Chapter C.1 of the thesis.
```julia
include("setup_25\\Cub_nak_smth2.jl")
```
The resulting file has been used in Figure C.6 of this thesis.

## setup_26
This setup produces the bilinear B-spline interpolation of the Rhine river section introduced in Chapter C.1 of the thesis.
```julia
include("setup_26\\Bilin2.jl")
```
The resulting file has been used in Figure C.7 of this thesis.

## setup_27
This setup produces the bicubic B-spline interpolation with free end condition of the Rhine river section introduced in Chapter C.1 of the thesis.
```julia
include("setup_27\\Bic_free2.jl")
```
The resulting file has been used in Figure C.8 of this thesis.

## setup_28
This setup produces the bicubic B-spline interpolation with not-a-knot end condition of the Rhine river section introduced in Chapter C.1 of the thesis.
```julia
include("setup_28\\Bic_nak2.jl")
```
The resulting file has been used in Figure C.9 of this thesis.

## setup_29
This setup produces the bicubic B-spline interpolation with free end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river section introduced in Chapter C.1 of the thesis.
```julia
include("setup_29\\Bic_free_smth2.jl")
```
The resulting file has been used in Figure C.10 of this thesis.

## setup_30
This setup produces the cubic B-spline interpolation with not-a-knot end condition and smoothing with smoothing factor $\lambda = 9999$ of the Rhine river section introduced in Chapter C.1 of the thesis.
```julia
include("setup_30\\Bic_nak_smth2.jl")
```
The resulting file has been used in Figure C.11 of this thesis.

## setup_31
The files in this setup are used to verify that the well-balanced property is fulfilled when working with B-spline interpolated bottom topographies. In this case, we are interested in the one dimensional case. Therefore the files 
- `linear2.jl`
- `cubic_free2.jl`
- `cubic_n-a-k2.jl`

are implemented in this folder.
These files determine the lake-at-rest error for a lake-at-rest problem when using linear, and cubic B-spline interpolated bottom topographies with free and not-a-knot end condition. The underlying data is the same cross-section data as introduced in Section C.1 of the thesis.

The implemented files run a simulation of the time interval `tspan = [0.0, 10.0]`. To run the simulations, execute:
```julia
include("setup_31\\linear2.jl")
include("setup_31\\cubic_free2.jl")
include("setup_31\\cubic_n-a-k2.jl")
```

Because we need the results of more time intervals than just `tspan = [0.0, 10.0]`, we have to perform the following steps afterwards to obtain all the necessary data:

1. Change `tspan` to `tspan = [0.0, 100.0]` for all the files and re-run the simulations as described above
2. Change `tspan` to `tspan = [0.0, 1000.0]` for all the files and re-run the simulations
3. Change `tspan` to `tspan = [0.0, 10000.0]` for all the files and re-run the simulations

The obtained errors can be found in Table C.1 of this thesis.

## setup_32
The files in this setup are used to verify that the well-balanced property is fulfilled when working with B-spline interpolated bottom topographies. In this case, we are interested in the two dimensional case. Therefore the files 
- `bilinear2.jl`
- `bicubic_free2.jl`
- `bicubic_n-a-k2.jl`

are implemented in this folder.
These files determine the lake-at-rest error for a lake-at-rest problem when using bilinear and bicubic B-spline interpolated bottom topographies with free and not-a-knot end condition. The underlying data is the same Rhine section data as introduced in Section C.1 of the thesis.

The implemented files run a simulation of the time interval `tspan = [0.0, 10.0]`. To run the simulations, execute:
```julia
include("setup_32\\bilinear2.jl")
include("setup_32\\bicubic_free2.jl")
include("setup_32\\bicubic_n-a-k2.jl")
```

Because we need the results of more time intervals than just `tspan = [0.0, 10.0]`, we have to perform the following steps afterwards to obtain all the necessary data:

1. Change `tspan` to `tspan = [0.0, 100.0]` for all the files and re-run the simulations as described above
2. Change `tspan` to `tspan = [0.0, 1000.0]` for all the files and re-run the simulations
3. Change `tspan` to `tspan = [0.0, 10000.0]` for all the files and re-run the simulations

The obtained errors can be found in Table C.2 of this thesis.

## setup_33
The file in this folder simulates a one dimensional dam break problem where the cross-section of the Rhine river valley introduced in Chapter C.1 has been used as the underlying data for the bottom topography.
At the end of the simulation, a plot is given of the state of the problem at the specified time point in `tspan[2]`.
To start the simulation, execute
```julia
include("setup_33\\dam_1d_2.jl")
```
This gives the plot in Figure C.12. This file can also be used to obtain the plots of Figures C.13-C.16.
To do so, set:
- For Figure C.13: `tspan = (0.0, 3.0)`
- For Figure C.14: `tspan = (0.0, 7.0)`
- For Figure C.15: `tspan = (0.0, 13.0)`
- For Figure C.16: `tspan = (0.0, 21.0)`

and execute the same command as above. 

## setup_34
The file in this folder simulates a two dimensional dam break problem where the section of the Rhine river valley introduced in Chapter C.1 has been used as the underlying data for the bottom topography.
To start the simulation, execute
```julia
include("setup_34\\2d_dam_break_App_C.jl")
```
This will produce `.h5` files for different steps of the simulations and save them in the `out` subfolder of this folder. These files then have to be converted into `.vtu` files. To do so, execute:
```julia
using Trixi2Vtk

trixi2vtk("setup_34/out/solution_*.h5", output_directory="setup_34/out", nvisnodes=15)
``` 
The `.vtu` files will be saved in the `out` subfolder. To obtain the plots as in Figures C.17-C.21, we need to open ParaView and do the following steps:

**For the bottom topography**

1. Load `solution_*.vtu` from the `out` subfolder and select `b` → `Apply`
2. Select Filter `Extract Surface` → `Apply`
3. Select Filter `Linear Extrusion` → `Apply`
4. Select Filter `Elevation`, under `Properties` select the button `Z Axis` → `Apply`
5. Select Filter `Calculator`, under `Properties`, set `Results Array Name` to **bottom** and enter the function $floor(Elevation)*(b*20-750)$ → `Apply`
6. Select Filter `Wrap by Scalar` → `Apply`
7. Under `WrapByScalar1` go to `coloring` and click on `Edit`. There select `Interpret Values As Categories` and select under `Color Mapping Parameters` the colour `HTML: #555500` → `Render Views`

**For the water surface**

1. Load `solution_*.vtu` from the `out` subfolder and select `H` and `b` → `Apply`
2. Select Filter `Extract Surface` → `Apply`
3. Select Filter `Linear Extrusion` → `Apply`
4. Select Filter `Elevation`, under `Properties` select the button `Z Axis` → `Apply`
5. Select Filter `Calculator`, under `Properties`, set `Results Array Name` to **water** and enter the function $floor(Elevation)*((H-b)*20)+(b*20-750)$ → `Apply`
6. Select Filter `Wrap by Scalar` → `Apply`
7. Under `WrapByScalar2` go to `coloring` and click on `Edit`. There select `Interpret Values As Categories` and select under `Color Mapping Parameters` the colour `HTML: ##00aaff` and set `Nan Opacity` to `0.5`→ `Render Views`

The following `Time` values represent the snapshots for Figures C.17-C.21

- Figure C.17: `0`
- Figure C.18: `10`
- Figure C.19: `19`
- Figure C.20: `32`
- Figure C.21: `47`