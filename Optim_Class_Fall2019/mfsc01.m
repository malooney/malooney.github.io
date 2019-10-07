  % MFSC01 Model function file for optimal growth model
  
function out = mfsc01(flag,s,x,Vs,alpha,delta,gam,rho);
switch flag
case 'x';                         % OPTIMAL CONTROL as a function of state 
                                  % variable s and shadow price Vs
  out = Vs.^(-1./gam);
case 'f';                         % REWARD FUNCTION
  out = (x.^(1-gam)-1)./(1-gam);
case 'g';                         % DRIFT FUNCTION
  out = alpha*log(s+1)-delta*s-x;
case 'sigma'                      % DIFFUSION FUNCTION
  out = [];
case 'rho'                        % DISCOUNT FUNCTION GIVEN S
  out = rho+zeros(size(s,1),1);
end

% A diffusion is a continuous-time Markov process (with continuous 
% sample paths, i.e. no jumps).
% Simplest possible diffusion: standard Brownian motion.
% The Drift Function is related to the Diffusion Function. In this context
% we have Brownian motion with drift.