using Plots, SpecialFunctions

include("GetPotentialFromAngles.jl")
include("ProcessFittingData.jl")

function FooA(r::Real)
    return erf(r)/r;
end

function FooB(r::Real)
    a = 1.29514588963436
    b = 4.1028848605349
    c = 0.960004510529105
    d = 0.572707883508332

    return a/(r+b) + c*exp(-d*r);
end

λ1 = 2.45;
λ2 = 1.65;

l = collect((10.0/300.0).*(0:300));

x0 = XCOrderEE0.(λ1,λ2,l)./XCOrderEE0.(λ1,λ2,0);
x1 = XCOrderEE1.(λ1,λ2,l)./XCOrderEE1.(λ1,λ2,0);
x2 = XCOrderEE2.(λ1,λ2,l)./XCOrderEE2.(λ1,λ2,0);
x3 = XCOrderEE3.(λ1,λ2,l)./XCOrderEE3.(λ1,λ2,0);
x4 = XCOrderEE4.(λ1,λ2,l)./XCOrderEE4.(λ1,λ2,0);
x5 = XCOrderEE5.(λ1,λ2,l)./XCOrderEE5.(λ1,λ2,0);
x6 = XCOrderEE6.(λ1,λ2,l)./XCOrderEE6.(λ1,λ2,0);
x7 = XCOrderEE7.(λ1,λ2,l)./XCOrderEE7.(λ1,λ2,0);
x8 = XCOrderEE8.(λ1,λ2,l)./XCOrderEE8.(λ1,λ2,0);
x9 = XCOrderEE9.(λ1,λ2,l)./XCOrderEE9.(λ1,λ2,0);
x10 = XCOrderEE10.(λ1,λ2,l)./XCOrderEE10.(λ1,λ2,0);


# x0 = XCOrderEN0.(λ1,l)./XCOrderEN0.(λ1,0);
# x1 = XCOrderEN1.(λ1,l)./XCOrderEN1.(λ1,0);
# x2 = XCOrderEN2.(λ1,l)./XCOrderEN2.(λ1,0);
# x3 = XCOrderEN3.(λ1,l)./XCOrderEN3.(λ1,0);
# x4 = XCOrderEN4.(λ1,l)./XCOrderEN4.(λ1,0);
# x5 = XCOrderEN5.(λ1,l)./XCOrderEN5.(λ1,0);
# x6 = XCOrderEN6.(λ1,l)./XCOrderEN6.(λ1,0);
# x7 = XCOrderEN7.(λ1,l)./XCOrderEN7.(λ1,0);
# x8 = XCOrderEN8.(λ1,l)./XCOrderEN8.(λ1,0);
# x9 = XCOrderEN9.(λ1,l)./XCOrderEN9.(λ1,0);
# x10 = XCOrderEN10.(λ1,l)./XCOrderEN10.(λ1,0);


plot(l,x0,label=L"n = 0");
plot!(l,x1);
plot!(l,x2);
plot!(l,x3);
plot!(l,x4);
plot!(l,x5);
plot!(l,x6);
plot!(l,x7);
plot!(l,x8);
plot!(l,x9);
plot!(l,x10);
plot!(xlims=(0,5))

