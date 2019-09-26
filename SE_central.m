% Written by Amirkhosro Vosughi, Washington State University

%This Script calculated vulnerability of each state. The calculation is 
% done thorugh distributed Observability analysis

function ErrVariacne = SE_central(A,B,C) 

d = size(A,1);

% Compute Vulnerability of each node from selected set of effected nodes
% The amount fo vulnerability of each node is shown as an entity of Vector

Wo =zeros(d);
for k = 0:50
    Z = C*A^k;
    Wo = Wo+Z'*Z;
end
ErrVariacne = B'*Wo^-1*B;






