% Written by Amirkhosro Vosughi, Washington State University

%This Script calculated vulnerability of each state. The calculation is 
% done thorugh distributed Controllability analysis
function ErrVariacne = SE_distributed(A,B,C) 


Tt=50;
d = size(A,1);


%%% Initialize the P matrix
P0=C;
P=zeros(Tt,d);
P(1,:)=P0;

Wo= P(1,:)'*P(1,:);
%%%% First Recursion loop (To calculate Wo)
for i =2:Tt
       Q=P(i-1,:);
       P(i,:) = Q*A;
       Wo=Wo+  P(i,:)'*P(i,:);  % Not sure if it is distributed or not
end

%%% Second Resusion loop (To calculate inverse of Wo and solve linear
%%% equation
S = LinearEquation(Wo,B);
ErrVariacne = B'*S;
% What we do, we save s row (source row) of A^k matrices in rpw og P matrix
% and then square and sum them.

