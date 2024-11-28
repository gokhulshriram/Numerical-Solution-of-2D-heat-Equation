%% Variable Definition/Declaration
close all
clear
clc
dt=0.0001;                      %can change value of dt for different cases 
x=0:1/40:1;
y=0:1/40:1;
dx=1/40;
m=size(x,2);
n=size(y,2);
w=zeros(m,n); 
%% BC         
timec = 0.16;
w(1:end,1)=1-y.^3;              %w(0,y,t) = 1-y.^3
w(1:end,end)=1-sin(pi/2*y);     %w(1,y,t) = 1-sin(pi/2*y)
w(1,1:end)=ones(size(x));       %w(x,0,t) = 1 
w(end,1:end)=zeros(size(x));    %w(x,1,t) = 0 ; technically not necessary
[X,Y]=meshgrid(x,y);            %create a grid and matrices X and Y which are compatible with x and y
%% Solving
t=0;
w_new=w;
forpl = zeros(1,timec/dt);                       %stores w values for x=0.4 at different times
counter = 1;
while t<=timec                                               %time control 
    for rows=2:(m-1)                                        %traverse through all rows
        for columns=2:(n-1)                                 %traverse through all columns
               w_new(rows,columns)=w(rows,columns)+(dt/(2*dx^2).*(w(rows+1,columns)+w(rows-1,columns)+w(rows,columns+1)+w(rows,columns-1)-4*w(rows,columns)));      %Explicit Euler update equation 
               if rows == 14 && columns == 14
                   forpl(counter) = w_new(rows,columns);
                   counter = counter +1;
               end
        end
    end
    t=t+dt;                                                 %increment t by dt
    w=w_new;
end
%% plotting
contourf(X,Y,w_new)
colormap
colorbar
xlabel('X')
ylabel('Y')