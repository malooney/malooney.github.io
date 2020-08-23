  clear;

% DEMDDP01 Mine Management Model
  fprintf('\nDEMDDP01 MINE MANAGEMENT MODEL\n')
  close all

% Enter model parameters
  A = 1;                    % price of ore
  alpha = 0.2;               % elasticity
  sbar  = 60;                   % initial ore stock
  r = [0.02 0.06 0.1];
  delta = 1./(1+r);                  % discount factor  
  
% Construct state and action spaces
  S = (0:0.1:sbar)';                % vector of states
  X = (0:0.1:sbar)';                % vector of actions
  n = length(S);                % number of states
  m = length(X);                % number of actions


% Construct reward function (f) and state transition function (g)
% Non-vectorized version

  f = zeros(n,m);
  for i=1:n
  for k=1:m
    if X(k)<=S(i)
      f(i,k) = X(k)^(1-alpha);
    else
      f(i,k) = -inf;
    end
  end
  end 
  g = zeros(n,m);
  for i=1:n
  for k=1:m
    snext = S(i)-X(k);
    g(i,k) = getindex(snext,S);
  end
  end


for i = 1:3
% Pack model data
  clear model
  model.reward     = f;
  model.transfunc  = g;
  model.discount   = delta(i);

% Solve model using the function "ddpsolve"
  [v,x,pstar] = ddpsolve(model);
  vc(:,i) = v;
  xc(:,i) = x
  pstarc(:,:,i) = full(pstar);
end
% Plot optimal value function
  subplot(2,2,1);
  plot(S,vc);
  title('Optimal Value Function');
  xlabel('Stock'); ylabel('Value');
  legend({'r = 0.02', 'r = 0.06', 'r = 0.1'},'location','northwest');

% Plot optimal policy function
  subplot(2,2,2)
  plot(S,X(xc)); 
  title('Optimal Extraction Policy');
  xlabel('Stock'); ylabel('Extraction');
  legend({'r = 0.02', 'r = 0.06', 'r = 0.1'}, 'location','northwest');
  
% Generate optimal state and action paths
  sinit = getindex(sbar,S); nyrs = 30;
  for i = 1:3
      [spath xpath] = ddpsimul(pstarc(:,:,i),sinit,nyrs,x);
      spathc(:,i) = spath;
      xpathc(:,i) = xpath;
  end

% Plot optimal state path
  subplot(2,2,3);
  plot(0:nyrs,S(spathc));
  title('Optimal State Path');
  xlabel('Year'); ylabel('Stock');
  legend('r = 0.02', 'r = 0.06', 'r = 0.1');
  
% Plot optimal action path
  subplot(2,2,4);
  plot(0:nyrs,X(xpathc));
  title('Optimal Action Path');
  xlabel('Year'); ylabel('extraction');
  legend('r = 0.02', 'r = 0.06', 'r = 0.1');
