

struct SimulationParameters{I <: Integer, F <: AbstractFloat} <: AbstractParameters
    use_MB::Bool
    use_iceflow::Bool
    plots::Bool
    velocities::Bool
    overwrite_climate::Bool
    use_glathida_data::Bool
    tspan::Tuple{F, F}
    step::F
    multiprocessing::Bool
    workers::I
    working_dir::String
    test_mode::Bool
    rgi_paths::Dict{String, String}
    ice_thickness_source::String
end


"""
    SimulationParameters(;
                        use_MB::Bool = true,
                        use_iceflow::Bool = true,
                        plots::Bool = true,
                        velocities::Bool = true,
                        overwrite_climate::Bool = false,
                        use_glathida_data::Bool = false,
                        tspan::Tuple{F, F} = (2010.0,2015.0),
                        step::F = 1/12,
                        multiprocessing::Bool = true,
                        workers::I = 4,
                        working_dir::String = "",
                        test_mode::Bool = false,
                        rgi_paths::Dict{String, String} = Dict{String, String}(),
                        ice_thickness_source::String = "Farinotti19",
        )
Initialize the parameters for a simulation.
Keyword arguments
=================
    - `use_MB`: Determines if surface mass balance should be used.
    - `plots`: Determines if plots should be made.
    - `overwrite_climate`: Determines if climate data should be overwritten
    - 'use_glathida_data': Determines if data from the Glathida data set should be used
"""
function SimulationParameters(;
            use_MB::Bool = true,
            use_iceflow::Bool = true,
            plots::Bool = true,
            velocities::Bool = true,
            overwrite_climate::Bool = false,
            use_glathida_data::Bool = false,
            tspan::Tuple{F, F} = (2010.0,2015.0),
            step::F = 1/12,
            multiprocessing::Bool = true,
            workers::I = 4,
            working_dir::String = "",
            test_mode::Bool = false,
            rgi_paths::Dict{String, String} = Dict{String, String}(),
            ice_thickness_source::String = "Farinotti19",
            ) where {I <: Integer, F <: AbstractFloat}

    @assert ((ice_thickness_source == "Millan22") || (ice_thickness_source == "Farinotti19")) "Wrong ice thickness source! Should be either `Millan22` or `Farinotti19`."

    simulation_parameters = SimulationParameters(use_MB, use_iceflow, plots, velocities,
                                                overwrite_climate, use_glathida_data,
                                                Sleipnir.Float.(tspan), Sleipnir.Float(step), multiprocessing, Sleipnir.Int(workers), working_dir, test_mode, rgi_paths, ice_thickness_source)

    if !ispath(working_dir)
        mkpath(joinpath(working_dir, "data"))
    end

    return simulation_parameters
end

Base.:(==)(a::SimulationParameters, b::SimulationParameters) = a.use_MB == b.use_MB && a.use_iceflow == b.use_iceflow && a.plots == b.plots &&
                                      a.velocities == b.velocities && a.overwrite_climate == b.overwrite_climate && a.use_glathida_data == b.use_glathida_data &&
                                      a.tspan == b.tspan && a.step == b.step && a.multiprocessing == b.multiprocessing &&
                                      a.workers == b.workers && a.working_dir == b.working_dir && a.test_mode == b.test_mode && a.rgi_paths == b.rgi_paths &&
                                      a.ice_thickness_source == b.ice_thickness_source
