% Written by Amirkhosro Vosughi, Washington State University

%This Script calculated vulnerability of each state. The calculation is 
% done thorugh distributed Controllability analysis
function Energy = TC_distributed(A,B,C) 


Tt=51;
d = size(A,1);



% Give the number of nodes that their states might be influenced, So a
% vector B1 is given, if the node state i influenced, its values is
% equal to 1, otherwise its values is equal to zero, B matrix is generated
% by for loop afterwards


%%% Initialize the P matrix
P0=B;
P=zeros(d,Tt);
P(:,1)=P0;
A2=A.^2;


%%%% Recursion loop
for i =2:Tt
       Q=P(:,i-1);
       P(:,i) = (A*Q);        
end

P2= P.^2;
QQ=sum(P2');

TC=QQ.^-1;
%Energy = C*TC';
idx = find(C==1);
Energy = TC(idx);
% What we do, we save s row (source row) of A^k matrices in rpw og P matrix
% and then square and sum them.

