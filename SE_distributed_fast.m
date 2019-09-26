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
delta = zeros(length(A),1);

n=length(A);
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

       % original
       %delta = -rho*Gamma*(Zc*(Zc'*X(:,k-1))-B); %The praranteses are placed for making sure of distributed implementation of algorithm, each node has track of variable z
       
       % base on neighbours, Faild, doesn't work
       %for i = 1:length(A)
       %    % make access limited
       %    Gamma_0=zeros(length(A));
       %    Gamma_0(i,i)=Gamma(i,i);
           
       %    neig = find(A(i,:)~= 0);
       %    Zc_0= zeros(size(Zc));
       %    Zc_0(neig,:)=Zc(neig,:);
       %    X_0= zeros(length(A),1);
       %    X_0(neig)=X(neig,k-1);
           
       %    Delta = -rho*Gamma_0*(Zc_0*(Zc_0'*X_0)-B);
       %    delta(i)=Delta(i);
       %end
       
       % Distributed calculation of Zc'*X(k-1) in each step
       QQ = Zc'*X(:,k-1);
       
       Q =zeros(size(Zc));
       Q(:,1)=X(:,k-1);
       for i = 2:size(Zc,2)
           Q(:,i)=A*Q(:,i-1);
       end
       ZcX=C*Q; % Data has been stored in Target node, we must braod cast it to all nodes
       delta = -rho*Gamma*(Zc*ZcX'-B);
       
       X(:,k)=X(:,k-1)+delta; % it is not distributed yet :(
end

ErrVariacne = B'*X(:,Tt);



