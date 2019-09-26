function Solution = LinearEquation(A,b)


% Centralized solution (Ax=b)
x_direct=inv(A)*b;

% Distributed solution (Ax=b)
x=zeros(length(A),1);

rho = 0.01;
G1 = diag(A);
G2 = G1.^-1;
G = diag(G2);

epsilon= 10^-5;
Norm_delta = 1;

%while (Norm_delta > epsilon)
for i = 1:100000
    delta = -rho*G*(A*x-b);
      x = x + delta;
      Norm_delta = delta'*delta;   
end

Solution = x;
