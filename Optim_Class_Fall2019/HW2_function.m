

function [out1,out2,out3] = mfdp08(flag, s, x, e, alpha, beta, gamma, cost);
switch flag
case 'b'; % BOUND FUNCTION
  out1 = ;                            % xl
  out2 = ;                                         % xu
case 'f'; % REWARD FUNCTION
  out1 = ;   % f
  out2 = ;                        % fx
  out3 = ;                    % fxx
case 'g'; % STATE TRANSITION FUNCTION
  out1 = ; % g
  out2 = ;                     % gx
  out3 = ;                     % gxx
end
