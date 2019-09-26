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
Gamma = eye(d); %==> gamma must be disigned in better way

%%%% Iteration
for k =2:Tt
       Z(:,k)=A'*Z(:,k-1);
       Zc = Z(:,1:k);
       
       %select Gamma dynamically
       G = Zc.^2;
       G = sum(G,2);
       ind=find(G==0);
       G(ind)=1;
       G=G.^-1;
       Gamma=diag(G);
       
       delta = -rho*Gamma*(Zc*(Zc'*X(:,k-1))-B); %The praranteses are placed for making sure of distributed implementation of algorithm, each node has track of variable z
       X(:,k)=X(:,k-1)+delta;
end

ErrVariacne = B'*X(:,Tt);



