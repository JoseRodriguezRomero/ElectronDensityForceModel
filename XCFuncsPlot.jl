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

λ = (λ1*λ2)/(λ1+λ2);
l = collect((10.0/300.0).*(0:300));

x0 = XCOrder0.(λ,l)./XCOrder0.(λ,0.000001);
x1 = (exp.(-λ.*(l.^2.0)).*XCOrder1.(λ,l))./XCOrder1.(λ,0);
x2 = (exp.(-λ.*(l.^2.0)).*XCOrder2.(λ,l))./XCOrder2.(λ,0);
x3 = (exp.(-λ.*(l.^2.0)).*XCOrder3.(λ,l))./XCOrder3.(λ,0);
x4 = (exp.(-λ.*(l.^2.0)).*XCOrder4.(λ,l))./XCOrder4.(λ,0);
x5 = (exp.(-λ.*(l.^2.0)).*XCOrder5.(λ,l))./XCOrder5.(λ,0);
x6 = (exp.(-λ.*(l.^2.0)).*XCOrder6.(λ,l))./XCOrder6.(λ,0);
x7 = (exp.(-λ.*(l.^2.0)).*XCOrder7.(λ,l))./XCOrder7.(λ,0);
x8 = (exp.(-λ.*(l.^2.0)).*XCOrder8.(λ,l))./XCOrder8.(λ,0);
x9 = (exp.(-λ.*(l.^2.0)).*XCOrder9.(λ,l))./XCOrder9.(λ,0);
x10 = (exp.(-λ.*(l.^2.0)).*XCOrder10.(λ,l))./XCOrder10.(λ,0);


# x0 = XCOrder0.(λ,l)./XCOrder0.(λ,0);
# x1 = (XCOrder1.(λ,l))./XCOrder1.(λ,0);
# x2 = (XCOrder2.(λ,l))./XCOrder2.(λ,0);
# x3 = (XCOrder3.(λ,l))./XCOrder3.(λ,0);
# x4 = (XCOrder4.(λ,l))./XCOrder4.(λ,0);
# x5 = (XCOrder5.(λ,l))./XCOrder5.(λ,0);
# x6 = (XCOrder6.(λ,l))./XCOrder6.(λ,0);
# x7 = (XCOrder7.(λ,l))./XCOrder7.(λ,0);
# x8 = (XCOrder8.(λ,l))./XCOrder8.(λ,0);
# x9 = (XCOrder9.(λ,l))./XCOrder9.(λ,0);
# x10 = (XCOrder10.(λ,l))./XCOrder10.(λ,0);


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

