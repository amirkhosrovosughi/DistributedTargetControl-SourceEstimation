% Written by Amirkhosro Vosughi, Washington State University

%This Script calculated vulnerability of each state. The calculation is 
% done thorugh distributed Controllability analysis

function Energy = TC_central(A,B,C) 

d = size(A,1);

% Compute Vulnerability of each node from selected set of effected nodes
% The amount fo vulnerability of each node is shown as an entity of Vector

Acc =0;
for k = 0:50
    E = C*A^(k)*B;
    Acc = Acc+E*E';
end
W_inv= Acc^-1;

Energy = W_inv;






