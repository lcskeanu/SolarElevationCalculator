function D = solarDeclination(dayOfYear)
%--------------------------------------------------------------------------
% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 2
%--------------------------------------------------------------------------
% SOLAR DECLINATION AS FUNCTION OF YEAR
% Input 1: dayOfYear : day of year - a number between 1 and 365-366
% Output1: D   : solar declination in degrees

%%
% Angular Fraction of Year
d = (dayOfYear-1) * 360 / 365.2425;
l = d + 279.9348;
% Sigma
sigma = l + 0.4087*sind(l) + 1.8724*cosd(l) - 0.0182*sind(2*l) + 0.0083*cosd(2*l);
sin_d = sind(23.437) *sind(sigma); % calculate 'sin D'
D = asind( sin_d);
