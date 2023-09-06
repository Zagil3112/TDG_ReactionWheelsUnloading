B = [-30e-6 35e-6 10e-5];
torques = [0 0 1.332e-5];

Bx = B(1);
By = B(2);
Bz = B(3);
K = 0.05667;
Tx = torques(1);
Ty = torques(2);
Tz = torques(3);

% F(1) = (x(1)+1)*(10-x(1))*(1+x(2)^2)/(1+x(2)^2+x(2));
% F(2) = (x(2)+2)*(20-x(2))*(1+x(1)^2)/(1+x(1)^2+x(1));

 F =  @(x)[0*x(1)+K*Bz*x(2)-K*By*x(3)-Tx;
          -K*Bz*x(1)+0*x(2)+K*Bx*x(3)-Ty;
          K*By*x(1)-K*Bx*x(2)+0*x(3)-Tz];
tic 
%%
rng default % For reproducibility
VoltageFS = 10;
N = 100; % Try 10 random start points
pts = 100*randn(N,3); % Initial points are rows in pts
soln = zeros(N,3); % Allocate solution
opts = optimoptions('fsolve','Display','off','FunctionTolerance',1e-20,'OptimalityTolerance',1e-20,'Algorithm','trust-region-dogleg');
for k = 1:N
    soln(k,:) = fsolve(F,pts(k,:),opts); % Find solutions
end

idx = soln(:,1) >= -VoltageFS & soln(:,2) >= -VoltageFS & soln(:,3)>= -VoltageFS & ...
    soln(:,1) <= VoltageFS & soln(:,2) <= VoltageFS & soln(:,3)<= VoltageFS;
soln_filter = soln(idx,:);
soln_filter = soln_filter(1,:)
toc