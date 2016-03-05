syms y;
x = 0:0.11:10;
for i = 1:length(x)
    
    s = solve(17*y^2 + x(i) - sin(y), y);
    double(s);
    plot(double(s), x(i), 'b*');
    hold on;
end;

% s = solve(y^2 - 7*y, y)