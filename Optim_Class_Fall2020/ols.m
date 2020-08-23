
clc;clear;

x=randn(2000,2);

x= [ones(2000,1) x];

y=randn(2000,1);

b_wrong= inv(x'*x)*x'*y;

b_correct= x\y;

e= y-(x*b_correct);

N= length(x);

k= length(b_correct);

sigma= (e'*e)/(N-k-1);

vcov= sigma* inv(x'*x);

se= sqrt(diag(vcov));

fitlm(x, y, 'intercept', false)

b_correct

se