%% Variable Definition/Declaration
close all
clear
clc
dt=0.0001;  %can change value of dt for different cases 
dx=1/40;     %grid size
x=0:dx:1;
y=0:dx:1;
m=size(x,2);
n=size(y,2);
w=zeros(m,n);
%% BC                  
w(1:end,1)=1-y.^3;              %w(0,y,t) = 1-y.^3
w(1:end,end)=1-sin(pi/2*y);     %w(1,y,t) = 1-sin(pi/2*y)
w(1,1:end)=ones(size(x));       %w(x,0,t) = 1 
w(end,1:end)=zeros(size(x));    %w(x,1,t) = 0 ; technically not necessary
[X,Y]=meshgrid(x,y);            %create a grid and matrices X and Y which are compatible with x and y
%% Solving
t=0;
w_new = w;
forpl = zeros(1,0.01/dt);                       %stores w values for x=0.4 at different times
counter = 1;
while t <= 0.16                                %time control 
    w_prev = w_new;
    for rows = 2:(m - 1)                        %traverse through all rows
        for columns = 2:(n - 1)                 %traverse through all columns
            w_new(rows, columns) = w_prev(rows, columns) + (dt/(2*dx^2)) * ((w_prev(rows + 1, columns) - 4 * w_prev(rows, columns) + w_prev(rows - 1, columns) + w_prev(rows, columns + 1) + w_prev(rows, columns - 1))+(w_new(rows + 1, columns) - 4 * w_new(rows, columns) + w_new(rows - 1, columns) + w_new(rows, columns + 1) + w_new(rows, columns - 1)));
            if rows == 16 && columns == 16
                forpl(counter) = w_new(rows,columns);
                counter = counter +1;
            end
        end
    end
    t = t + dt;
end
%% contour plots
% Plotting the values stored in forpl over time t
time = 0:dt:0.16; % Creating time points from 0 to 0.16 with intervals of dt

plot(time, forpl);
xlabel('Time (t)');
ylabel('Temperature at x=y=0.4 from t=0 to t=0.16');
title('Time');
