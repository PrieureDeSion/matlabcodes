syms i;
v = -10:0.5:10;
n = 1; is = 1e-5; Vt = 1; r = 1e5;
% eq = ==0;
for it=1:length(v)
    s = solve((i - is*(exp(n*v(it)/Vt)-1))*r -v(it), i);
    plot(s, v(it));
    hold on;
end;
