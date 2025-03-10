
export Simulation, Results

# Abstract type as a parent type for simulations
abstract type Simulation end

include("results/Results.jl")

###############################################
################### UTILS #####################
###############################################

include("simulation_utils.jl")
include("results/results_utils.jl")
include("results/results_plotting_utils.jl")
include("results/results_plotting_video_utils.jl")
