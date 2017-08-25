struct ScenarioBelief{S, O, RS<:DESPOTRandomSource}
    scenarios::Vector{Pair{Int,S}}
    random_source::RS
    depth::Int
    _obs::Nullable{O} # this might be replaced by ao_history later - use previous_obs to access
    # ao_history::Nullable{AOHistory}() # may put this in later
end

rand(rng::AbstractRNG, b::ScenarioBelief) = b.scenarios[rand(rng, 1:length(b.scenarios))]
iterator(b::ScenarioBelief) = (last(p) for p in b.scenarios)
previous_obs(b::ScenarioBelief) = b._obs

init_bounds(bounds, pomdp, sol) = bounds

initialize_belief(::PreviousObservationUpdater{T}, b::ScenarioBelief{S, Union{}}) where {S,T} = Nullable{T}()
initialize_belief(::PreviousObservationUpdater{T}, b::ScenarioBelief{S, T}) where {S,T} = previous_obs(b)
