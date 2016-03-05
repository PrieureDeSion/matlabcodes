x = 0:pi/8:10*pi
%y = sin(x)*log(x);
%would give error.. :) dimensions
y = sin(x).*log(x);
z= cos(x).*x;
plot(x, y, 'r-p', 'MarkerSize', 5);
xlabel('x from 0 to 10\pi');
ylabel('\bfsin(x)*log(x)', 'FontSize', 20);
legend('sin(x)*log(x)');
title('Sample Plot for y = blabla');
[ymax id] = max(y);
xmax = x(id);
hold on;
plot (xmax, ymax, 'b*', 'MarkerSize', 15); %plotting a point (marking)
hold on;
plot (x, cos(x), 'g-o');
legend('sin(x)*log(x)', 'max', 'cos(x)');
%[x y] = meshgrid[0:pi/8:10*pi];
%surf(x, y, sin(x).*sin(y));

%clf to clear figure window