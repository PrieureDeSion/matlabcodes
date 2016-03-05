%% This is a cell
% absence of semicolon causes printing
a =2; b= 10; c=12;
s2 = (-b - sqrt(b^2 - 4*a*c))/(2*a)
s1 = (-b + sqrt(b^2 - 4*a*c))/(2*a)

%% This can be another independent cell
% Let's see MATLAB's function
eq = [2 10 12 45 3 4 9 7 875 5];
s=roots(eq)
%% MATLAB poly fn
root_known = [1 3 -4];
poly(root_known)

roots_known = [-2+2i -2-2i];
poly(roots_known)
