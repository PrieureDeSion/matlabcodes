
%% Computer Vision Project
% Poisson solver for seamless cloning using Gauss Seidal method
% Goutam Bhat, Ashwin Khadke, Riddhish Bhalodia
% Date: 3/4/2015

%% 
% The function takes as input the source patch, the destination image, the mask for the source image and
% the location (top left corner)  in the destination image where the editing is to be done

% Output is the edited image


function out = poisson_solver(dst_img, loc, src_img,mask_src,mode)
%% Initialization

[ h, w,~]=size(src_img);

% Af=b is the system of linear equations obtained from the poisson
% equation. Size of A would be less than h*w since the patch may not be
% rectangular. We would drop the useless rows and columns later.
%A=zeros(h*w,h*w);
A=spalloc(h*w,h*w,5*h*w);
b=zeros(h*w,1);

%mask keeps track of the pixels that are part of the patch. ie its 1 if the
%corresponding pixels is part of the patch. Else its 0
mask=zeros(1,h*w);

%% Filling the matrix A
for i=1:1:h % Can be further optimised
    for j=1:1:w
        if (mask_src(i,j)>0)
            mask((i-1)*w+j)=1; % (i,j) in reshaped matrix
            
            A((i-1)*w+j,(i-1)*w+j)=4;
            if (mask_src(i-1,j)>0)
                A((i-1)*w+j,(i-2)*w+j)=-1;
            else
                b((i-1)*w+j,1)=b((i-1)*w+j,1)+ dst_img(loc(1)+i-1,loc(2)+j);
            end
            
            if (mask_src(i+1,j)>0)
                A((i-1)*w+j,(i)*w+j)=-1;
            else
                b((i-1)*w+j,1)=b((i-1)*w+j,1)+ dst_img(loc(1)+i+1,loc(2)+j);
            end
            
            if (mask_src(i,j-1)>0)
                A((i-1)*w+j,(i-1)*w+j-1)=-1;
            else
                b((i-1)*w+j,1)=b((i-1)*w+j,1)+ dst_img(loc(1)+i,loc(2)+j-1);
            end
            
            if (mask_src(i,j+1)>0)
                A((i-1)*w+j,(i-1)*w+j+1)=-1;
            else
                b((i-1)*w+j,1)=b((i-1)*w+j,1)+ dst_img(loc(1)+i,loc(2)+j+1);
            end
            
            %Add the gradient field
            if mode == 1||mode == 4
                if mode == 1
                   vs=4*src_img(i,j)-src_img(i,j+1)-src_img(i,j-1)-src_img(i-1,j)-src_img(i+1,j);
                end
                
                if mode == 4
                   threshold = 5;
                   v = [src_img(i,j)- src_img(i,j+1), src_img(i,j)- src_img(i,j-1), src_img(i,j)- src_img(i+1,j), src_img(i,j)- src_img(i-1,j)]; 
                   v = v.*(double(abs(v)>threshold));
                   vs=sum(v);
                end    
            b((i-1)*w+j,1) = b((i-1)*w+j,1) + vs;
            end
            
            if mode ==2
            if abs(src_img(i,j)-src_img(i+1,j))>abs(dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i+1,loc(2)+j))
                v1=src_img(i,j)-src_img(i+1,j);
            else
                v1=dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i+1,loc(2)+j);
            end
            
            if abs(src_img(i,j)-src_img(i-1,j))>abs(dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i-1,loc(2)+j))
                v2=src_img(i,j)-src_img(i-1,j);
            else
                v2=dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i-1,loc(2)+j);
            end
            
            if abs(src_img(i,j)-src_img(i,j+1))>abs(dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i,loc(2)+j+1))
                v3=src_img(i,j)-src_img(i,j+1);
            else
                v3=dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i,loc(2)+j+1);
            end
            
            if abs(src_img(i,j)-src_img(i,j-1))>abs(dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i,loc(2)+j-1))
                v4=src_img(i,j)-src_img(i,j-1);
            else
                v4=dst_img(loc(1)+i,loc(2)+j)-dst_img(loc(1)+i,loc(2)+j-1);
            end
            
            b((i-1)*w+j,1)=b((i-1)*w+j,1)+v1+v2+v3+v4;
            end
            
            if mode==3
                src_lg_img=(src_img);
                alpha = 0;
                count = 0;
                for l=1:1:h-1
                    for m=1:1:w-1
                     if mask_src(i,j)>0
                      alpha = alpha + sqrt((src_lg_img(i,j)-src_lg_img(i+1,j))^2 + (src_lg_img(i,j)-src_lg_img(i,j+1))^2); 
                      count = count + 1;
                     end
                    end
                end
            alpha = 0.2*alpha/count;
            beta = 0.2;
              
              v_const=alpha^beta*(sqrt((src_lg_img(i,j)-src_lg_img(i+1,j))^2+(src_lg_img(i,j)-src_lg_img(i-1,j))^2+(src_lg_img(i,j)-src_lg_img(i,j+1))^2+(src_lg_img(i,j)-src_lg_img(i,j-1))^2))^(-beta);  
              v1 = v_const*(src_lg_img(i,j)-src_lg_img(i+1,j));
              v2 = v_const*(src_lg_img(i,j)-src_lg_img(i-1,j));
              v3 = v_const*(src_lg_img(i,j)-src_lg_img(i,j+1));
              v4 = v_const*(src_lg_img(i,j)-src_lg_img(i,j-1));
%               lapla = sqrt(((dst_img(loc(1)+i,loc(2)+j-1) - dst_img(loc(1)+i,loc(2)+j+1))/2)^2 + ((dst_img(loc(1)+i-1,loc(2)+j) - dst_img(loc(1)+i+1,loc(2)+j))/2)^2);
               b((i-1)*w+j,1) = b((i-1)*w+j,1) + v1+v2+v3+v4;%exp(alpha^beta*lapla^(-beta)*((dst_img(loc(1)+i,loc(2)+j-1) - dst_img(loc(1)+i,loc(2)+j+1))/2 + (dst_img(loc(1)+i-1,loc(2)+j) - dst_img(loc(1)+i+1,loc(2)+j))/2));
            end
        end
    end
end
            
%% Remove unwanted rows and columns
mask=mask>0;
A=A(mask, mask);
b=b(mask);

%% Solving the linear system
%Solve the equation using Gauss Seidal method
%x=gauss_seidal(A,b,200);

%Replace the original patch in destination image with the edited patch
x=A\b;
%x = bicg(A, b, [], 200);
patch=dst_img(loc(1):loc(1)+h-1,loc(2):loc(2)+w-1);
patch_vec=vec2mat(patch,1);
patch_vec(mask')=x;
patch=vec2mat(patch_vec,w);

dst_img(loc(1):loc(1)+h-1,loc(2):loc(2)+w-1) = patch;

out=dst_img;
end

