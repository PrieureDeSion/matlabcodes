x = 0:1:100;
y = 0:1:100;

V = zeros(101);

%boundary conditions

for i = 25:35
    for j = 25:35
        V(i, j) = 2;
    end
end
for i = 65:75
    for j = 65:75
        V(i, j) = 2;
    end
end

Vt = V;

%now the actual algorithm
err_tol = 1e-3;
err=1;
it =0;
nx = 101;ny=101; %can change

for k = 1:1000
    for i = 2:nx-2
        for j = 2:ny-2
            Vt(i,j) = (V(i+1,j) + V(i,j+1) + V(i-1,j) + V(i,j-1))/4;
        end
        
    end
   % err = sqrt(sum(sum((Vt-V).^2)));
    V=Vt;  
  
end 
   V(3, 5)
    surf(x, y, V);