%%
%Here we see how to plot a 3d function nicely, without any huggna
[x y]=meshgrid(-5:0.2:5);
f = @(a,b) a.*exp(-a.^2 - b.^2); %define a function
z = f(x, y); %call function and assign to z

surf(x,y,z);
zlabel('cool fn');
xlabel('\bfX');
ylabel('\bfY');