% Written by Amirkhosro Vosughi, Washington State University

%This Script calculated vulnerability of each state. The calculation is 
% done thorugh distributed Controllability analysis
function ErrVariacne = SE_distributed(A,B,C) 


Tt=100000;
d = size(A,1);


%%% Initialize the P matrix
Z_0=C';
Z=zeros(d,Tt);
Z(:,1)=Z_0;
X= zeros(d,Tt);

rho= 0.01;
Gamma = eye(d);
Flag_higher_order = 1;

epsilon = 10^-8;

%%%% Iteration
for k =2:Tt
        % avoid making Zc big to save computation time (avoiding higher oder A^k)
       if Flag_higher_order==1
           Z(:,k)=A'*Z(:,k-1);
           Zc = Z(:,1:k);
           Z1=Z(:,k);
           if Z1'*Z1 < epsilon
              Flag_higher_order=0; 
           end
           
           %select Gamma dynamically
           G = Zc.^2;
           G = sum(G,2);
           ind=find(G==0);
           G(ind)=1;
           G=G.^-1;
           Gamma=diag(G);
       end       

       
       delta = -rho*Gamma*(Zc*(Zc'*X(:,k-1))-B); %The praranteses are placed for making sure of distributed implementation of algorithm, each node has track of variable z
       X(:,k)=X(:,k-1)+delta; % it is not distributed yet :(
end

ErrVariacne = B'*X(:,Tt);



