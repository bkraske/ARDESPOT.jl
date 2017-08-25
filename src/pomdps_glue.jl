solve(sol::DESPOTSolver, p::POMDP) = DESPOTPlanner(sol, p)

function action(p::DESPOTPlanner, b)
    D = build_despot(p, b)

    check_consistency(p.rs)

    best_l = -Inf
    local best_a::action_type(p.pomdp)
    for ba in D.children[1]
        l = mean(D.l[bnode] for bnode in D.ba_children[ba])
        if l >= best_l
            best_l = l
            best_a = D.ba_action[ba]
        end
    end
    return best_a
end

function updater(p::DESPOTPlanner)
    return SIRParticleFilter(p.pomdp, p.sol.K, rng=p.rng)
end
