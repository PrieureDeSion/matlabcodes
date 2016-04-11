clear;clear All;
syms x k L n;
f=exp(x);
evalin(symengine,'assume(k,Type::Integer)');
a = @(f,x,k,L) int(f*cos(k*pi*x/L)/L,x,-L,L);
b = @(f,x,k,L) int(f*sin(k*pi*x/L)/L,x,-L,L);
fs = @(f,x,n,L) a(f,x,0,L)/2 + ...
    symsum(a(f,x,k,L)*cos(k*pi*x/L) + b(f,x,k,L)*sin(k*pi*x/L),k,1,n);
pretty(fs(f,x,10,1));

figure; 
for count=1:1:10
    ezplot(fs(f,x,count,1),-3,3)
    hold on
    ezplot(f,-3,3);
    hold off
    pause(1);
end
%hold off
%title('Partial sum with n=2')