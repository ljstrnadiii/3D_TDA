function [ T ] = timeToBirthDeath( birth, death, presentTime )

%Calculates the minimum distance to the endpoints of an
%interval if inside the interval, zero if outside the interval

% by Peter Bubenik, p.bubenik@csuohio.edu, November 2011

if (birth < presentTime && presentTime < death)
    T = min(presentTime - birth, death - presentTime);
else
    T = 0;
end;
   


