function R = rndweibmod(varargin)
%RNDWEIBMOD Random matrices from the modified Weibull distribution.
% 
% CALL:  R = rndweibmod(a,b,c,sz)
% 
% R      = a matrix of random numbers from the Weibull distribution
% a,b,c  = parameters of the modified Weibull distribution
%     sz = size(R)    (Default common size of a,b and c)
%          sz can be a comma separated list or a vector 
%          giving the size of R (see zeros for options).
%
% The modified Weibull distribution is defined by the distribution function
% 
%   F(x) = 1 - exp(-((x+|c|)/a)^b + |c/a|^b), x>=0, a,b>0
% 
% The random numbers are generated by the inverse method. 
%
% Example:
%   R=rndweibmod(1,2,2,1,100);
%   phat=plotweib(R)
%
% See also pdfweibmod,  cdfweibmod, invweibmod, fitweibmod, momweibmod

% Reference: Cohen & Whittle, (1988) "Parameter Estimation in Reliability
% and Life Span Models", p. 25 ff, Marcel Dekker.


% Tested on: matlab 5.3
% History: 
% revised pab 23.10.2000
%  - added comnsize
%  - added greater flexibility on the sizing of R
% rewritten ms 15.06.2000

error(nargchk(1,inf,nargin))
Np = 3;
options = struct; % default options
[params,options,rndsize] = parsestatsinput(Np,options,varargin{:});
if numel(options)>1
  error('Multidimensional struct of distribution parameter not allowed!')
end
[a,b,c] = deal(params{:});

if isempty(c), c = 0;end


if isempty(rndsize)
  csize = comnsize(a,b,c);
else
  csize = comnsize(a,b,c,zeros(rndsize{:}));
end
if any(isnan(csize))
    error('a, b and c must be of common size or scalar.');
end

R = invweibmod(rand(csize),a,b, c);





