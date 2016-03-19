x = 0:1:100;
y = 0:1:100;

V = zeros(101);

%boundary conditions
V(:,1) = sin(x/40);
V(:,101) = cos(x/40);
V(1, :) = cos(y/40);
V(101,:) = sin(y/40);
Vt = V;
%now the actual algorithm
err_tol = 1e-3;
err=1;
nx = 101;ny=101; %can change
it = 200;%enter no of iterations of algorithm

for k = 2:it
    for i = 2:nx-1
        for j = 2:ny-1
            Vt(i,j) = (V(i+1,j) + V(i,j+1) + V(i-1,j) + V(i,j-1))/4;
        end
        
    end
   % err = sqrt(sum(sum((Vt-V).^2)));
    V=Vt;    
  
end 
   V(3, 5)
    surf(x, y, V);
