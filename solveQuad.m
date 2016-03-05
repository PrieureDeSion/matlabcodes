function [p1 r1 r2] = solveQuad(coeff)
%This functions solves a quadratic eqn.

%another comment..
disp('The roots are:')
a = coeff(1); b=coeff(2); c=coeff(3);
s2 = (-b - sqrt(b^2 - 4*a*c))/(2*a);
s1 = (-b + sqrt(b^2 - 4*a*c))/(2*a);
r1=s1;
r2=s2;
p1 = subFun(coeff);
% or, return just one value like C or JAVA, make r=[s1;s2]
end
%the first comment block is the explanation obtained in 'help'.. machao
% also check doc and publish

function p= subFun(x)
p = sum(x);
end