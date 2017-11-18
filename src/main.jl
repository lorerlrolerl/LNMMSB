# module main
using LightGraphs;using GraphPlot;using Gadfly;using PyPlot;
inputtomodelgen=[100,4]; ## N, K
include("utils.jl")
include("modelgen.jl")
true_eta0 = readdlm("data/true_eta0.txt")[1]
network=FileIO.load("data/network.jld")["network"]
include("LNMMSB.jl")
include("init.jl");println("# of communities : ",length(communities))
lg = LightGraphs.DiGraph(network);# draw(PNG("Docs/net$(inputtomodelgen[1]).png", 30cm, 30cm), gplot(lg))
onlyK = length(communities)
model=LNMMSB(network, onlyK)
mb=deepcopy(model.mb_zeroer)
include("modelutils.jl")
preparedata(model)
mbsampling!(mb, model, "isns", model.mbsize)
include("trainutils.jl")

sum(model.train_outdeg)
sum(model.trainfnadj)
sum(model.trainbnadj)
length(model.train_nonlinks)
sum(model.ho_fadj)
sum(model.ho_badj)
sum(model.ho_fnadj)
sum(model.ho_bnadj)



















# end
