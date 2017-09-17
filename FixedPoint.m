function [ executionTime,result,theoreticalBound, mayDiverge,diverge] = FixedPoint(graphAx, X0, f, var, iMax, Es)
tic; % start
g = f + var; % return is of type (sym)
g = matlabFunction(symfun(g, var)); % g as (function_handle) for plotting
gDash = symfun(diff(g, var), var);
theoreticalBound = abs(double(gDash(X0)));
mayDiverge = 0;
diverge = 0;
if (theoreticalBound > 1)
    mayDiverge = 1;
end
i = 1;
Xi_1 = X0;
Ea = Es + 10;
iterations = zeros(iMax, 1);
roots = zeros(iMax, 1);
errors = zeros(iMax, 1);
while ( i <= iMax && Ea > Es)
    Xi = g(Xi_1);
    Ea = abs(Xi - Xi_1);
    iterations(i, 1) = i; % faster than iterations(i)-indexing
    roots(i, 1) = Xi;
    errors(i, 1) = Ea;
    Xi_1 = Xi;
    i = i + 1;
end
errors(1,1) = NaN;
iterations(i : iMax) = [];
roots(i : iMax) = [];
errors(i : iMax) = [];
if (i > iMax && Ea > Es)
    diverge = 1;
end
executionTime = toc; % end
plot(graphAx, g, var, X0, Xi);
result = cat(2, iterations, roots, errors);
end

 
function plot(graphAx, g, var, X0, Xr)
% set horizontal interval end
if (abs(X0) > abs(Xr))
    startPoint = -abs(X0);
    endPoint = abs(X0);
else
    startPoint = -abs(Xr);
    endPoint = abs(Xr);
end
% set margins
margin = (endPoint - startPoint) / 5;

% set vertical interval
if (Xr < 0)
    yMin = Xr - margin;
    yMax = margin;
else
    yMin = -margin;
    yMax = Xr + margin;
end

% plot
axes(graphAx.ax1);
hold on;
set(gca,'YLim',[yMin yMax]);
line([(startPoint - margin) (endPoint + margin)],[0 0], 'color', 'black'); % draw x-axis
line([X0 X0], [yMin yMax], 'color', 'yellow', 'LineStyle', '--'); % draw initial condition
line([Xr Xr], [yMin yMax], 'color', 'green', 'LineStyle', '--'); % draw exact root
line([(startPoint - margin) (endPoint + margin)], [(startPoint - margin) (endPoint + margin)], 'color', 'red'); % draw y = x
fplot(g,[(startPoint - margin) (endPoint + margin)]); % draw g(x)
grid on;
end
 
% (x^3 - 0.165 * x^2 + 3.993 * 10^-4), with x0 = 0.05, 0.06 --> slow convergence
% (x = sin(x)), with x0 = pi/2 --> slow convergence
% ( x^2 - 4), with x0 = 0 --> inf, nan
% (-0.5*x), with x0 = -0.25 --> working
% (x + 1), with x0 = 0.9 --> working --> enter: (-x - 1)
% (x - 100), with x0 = 50 --> working --> enter: (100 - x)
% (2*x*(1-x) - x), with x0 = 0.1 --> working
% (x), with x0 = 0.10 -->  working --> enter: (-x)