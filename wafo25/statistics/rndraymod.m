function R = rndraymod(varargin)
%RNDRAYMOD Random matrices from modified Rayleigh distribution
% 
% CALL:  R = rndraymod(b,c,sz)
%        R = rndraymod(phat,sz)
%     
%        R = matrix of random numbers
%        b = parameter
%      phat = Distribution parameter struct
%             as returned from FITRAY.  
%       sz = size(R)    (Default size(b))
%            sz can be a comma separated list or a vector 
%            giving the size of R (see zeros for options).
%
% The Rayleigh distribution is defined by its cdf
%
%  F(x;b) = 1 - exp(-(x+c)^2/(2b^2)+0.5(c/b)^2), x>=0
%
% The random numbers are generated by the inverse method. 
%
% Example:
%   R=rndraymod(2,1,1,100);
%   plotray(R);shg
%
% See also  pdfraymod, cdfraymod, invraymod, fitraymod, momraymod

% Reference: Cohen & Whittle, (1988) "Parameter Estimation in Reliability
% and Life Span Models", p. 181 ff, Marcel Dekker.


% Tested on: Matlab 5.3
% History: 
% revised PJ 03-Apr-2001
%  - added comnsize, nargchk
%  - made sizing of R more flexible
% revised jr 22.11.2000
% - 'reshape' introduced to obtain wanted dimension of output 
% added ms 15.06.2000

error(nargchk(1,inf,nargin))

Np = 2;
options = struct; % default options
[params,options,rndsize] = parsestatsinput(Np,options,varargin{:});
if numel(options)>1
  error('Multidimensional struct of distribution parameter not allowed!')
end

[b,c] = deal(params{:});
if isempty(c)
  c = 0;
end

if isempty(rndsize)
  csize = comnsize(b,c);
else
  csize=comnsize(b,zeros(rndsize{:}));
end
if any(isnan(csize))
  error('b must be a scalar or comply to the size info given.');
end
R = invraymod(rand(csize),b,c);


