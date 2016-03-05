%% Here's a way to compute using user input
% comment out multiple lines of code: select the lines, then ctrl+r.. to
% remove, ctrl+t
clear all;
coeff = input('Enter coeeficients: \n')
%s = roots(coeff)
disp('The roots are: ')
a = coeff(1); b=coeff(2); c=coeff(3);
s2 = (-b - sqrt(b^2 - 4*a*c))/(2*a)
s1 = (-b + sqrt(b^2 - 4*a*c))/(2*a)