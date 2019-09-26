clear all;

% First step is to give A matrix, 
% You give any squar matrix A

 %A11= [0.5,0.5,0,0,0];
 %A12= [0.33,.33,.33,0,0];
 %A13=[0,.33,.33,.33,0];
 %A14=[0,0,.33,.33,.33];
 %A15=[ 0,0,0,0.5,0.5];
 %A= [A11;A12;A13;A14;A15];  

A11= [1/4,1/4,1/4,0];
A12= [0,1/4,0,1/4];
A13=[1/4,0,1/4,1/4];
A14=[1/4,1/4,0,1/4];
A= [A11;A12;A13;A14];

%%% functions work for vector B & C matrices now
% B matrix (source node)
B =[0;1;0;0];

% C matrix (targey nodes)
C = [1,0,0,0];

Energy = TC_central(A,B,C)

Energy = TC_distributed(A,B,C)

ErrVariacne = SE_central(A,B,C)

ErrVariacne = SE_semi_distributed(A,B,C)

ErrVariacne = SE_distributed_fast(A,B,C) 