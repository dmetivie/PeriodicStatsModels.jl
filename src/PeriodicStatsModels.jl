module PeriodicStatsModels

# # Packages

# ## Utilities
using ArgCheck
using Base: OneTo
using ShiftedArrays: lead

# ## Optimization
using JuMP, Ipopt
using Optimization
using LsqFit

# Random and Distributions
using Distributions
using Random: AbstractRNG, GLOBAL_RNG

# ## Special function
using LogExpFunctions: logsumexp!, logsumexp

# ## HMM
#? Do we need both using ?
using HMMBase
using HMMBase: posteriors!, vec_maximum, EMHistory, update_a!, isprobvec # function not exported by default by HHMBase
using PeriodicHiddenMarkovModels
# using HMMBase: viterbi
using PeriodicHiddenMarkovModels: viterbi

# # Overloaded functions
import Distributions: fit_mle
import Base: rand
import Base: ==, copy, size
import HMMBase: fit_mle!, fit_mle
# import HMMBase: rand, forward, backward, forwardlog!, backwardlog!, viterbi, viterbi!, viterbilog!
import PeriodicHiddenMarkovModels: forward, backward, forwardlog!, backwardlog!, viterbi, viterbi!, viterbilog!

# # Code

include("utilities.jl")

# ## Generic MLE problem solved with Optimization
include("fit_mle_trig_Optim.jl")
export OptimMLE

# ## EM algorith for mixtures
include("Mixture/fit_mle_trig_EM.jl")

# ## Auto-regressive problems
include("AR/AR1.jl")

# ## HMM problem
include("HHMM_Bernoulli/periodichmm.jl")
include("HHMM_Bernoulli/mle.jl")
include("HHMM_Bernoulli/likelihoods.jl")
include("HHMM_Bernoulli/viterbi.jl")

include("HHMM_Bernoulli/update_A_B_jump.jl")
include("HHMM_Bernoulli/trig_conversion.jl")
include("HHMM_Bernoulli/mle_slice.jl")

export
    # periodichmm.jl
    HierarchicalPeriodicHMM,
    sort_wrt_ref!,
    randhierarchicalPeriodicHMM,
    rand,
    # messages.jl
    forward,
    backward,
    # likelihoods.jl
    loglikelihoods,
    likelihoods,
    viterbi,
    # trigonometric
    fit_θ!,
    fit_θ,
    fit_θᴬ!,
    fit_θᴮ!,
    polynomial_trigo,
    Trig2HierarchicalPeriodicHMM,
    # fit slice
    fit_mle_all_slices


export AR1
export model_for_loglikelihood_AR1, initialvalue_optimize!, model_for_loglikelihood_AR1_full
export μₜ, ρₜ, σₜ
export n_to_t


end
