function [sunrise sunset M] = getSunTimes( altitude, latitude, longitude, dayOfYear, TimeZone)
%--------------------------------------------------------------------------
% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 2
%--------------------------------------------------------------------------
%SUNRISE AND SUNSET TIMES
% Input 1 : altitude
% Input 2 : latitude 
% Input 3 : longitude
% Input 4 : day of year
% Input 5 : time zone
%                             
% Output1: sunrise time
% Output2: sunset time
%%
d = (dayOfYear-1) * 360 / 365.2425;
% Meridian passage
M = 12 + 0.12357 * sind(d) - 0.004289 * cosd(d) + ...
    0.153809 * sind(2*d) + 0.050783 * cosd(2*d);
% Sunrise and sunset solar elevation
A = -1.76459 * altitude^0.40795;
D = solarDeclination(dayOfYear);

% This is to make H an array. When you do not do this, it always returns
% an error.
H = dayOfYear;

cos_h = (sind(A) - sind(latitude)*sind(D)) / cosd(latitude) / cosd(D);

if (cos_h < -1)
    cos_h = -1;
elseif (cos_h > 1)
    cos_h = 1;
end

% Sunrise to noon
H = acosd(cos_h); 
L = longitude/15;
sunrise = TimeZone - L + M - H/15;
sunset = TimeZone - L + M + H/15;

% Daniel normalization
if (sunrise <0 ) sunrise = sunrise + 24;
elseif (sunrise >=24 ) sunrise = sunrise - 24;
end
if (sunset <0 ) sunset = sunset + 24;
elseif (sunset >=24 ) sunset = sunset - 24;
end
