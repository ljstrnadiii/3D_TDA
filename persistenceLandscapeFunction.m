function [ z ] = persistenceLandscapeFunction( sortedTimeTobirthDeathMatrixAtTimeT, x )
%
% The Persistence Landscape is a function on two variables: x,t.
% This function returns the value of the Persistence Landscape at the point
% (x,t).
% The first variable is a sorted matrix of the distance from t to the 
% endpoints of an interval that contains it. 
%
% by Peter Bubenik, p.bubenik@csuohio.edu, April 2012

n = (ceil(x));
if (n <= 0 || n > size(sortedTimeTobirthDeathMatrixAtTimeT,2))
    z = 0;
else
    z = sortedTimeTobirthDeathMatrixAtTimeT(n);
end
