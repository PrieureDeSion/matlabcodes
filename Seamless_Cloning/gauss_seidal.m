%% Computer Vision Project
% Gauss Seidal
% Goutam Bhat, Ashwin Khadke, Riddhish Bhalodia
% Date: 3/4/2015

%%
% Solves Ax=b iteratively. Max number of iterations-> iter

function out=gauss_seidal(A,b,iter)
[m,~]=size(b);
x=zeros(m,1);

    for k = 1:iter
        for i = 1:m
            x(i) = (1/A(i, i))*(b(i,1) - A(i, 1:m)*x + A(i, i)*x(i));
        end
    end
    error=A*x-b;
    fprintf('Maximum reprojection error is');
    max(abs(error))
    fprintf('Mean absolute error is');
    mean(abs(error))
out=x;    
end