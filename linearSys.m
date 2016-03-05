%%

A = [0 1 -3;2 3 -1;4 5 -2];
B = [-5;7;10];
x1 = inv(A)*B

x2 = A\B %another way to get inverse if multiplying later.. ulta divide