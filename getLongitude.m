function longitude = getLongitude()
%--------------------------------------------------------------------------
% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 2
%--------------------------------------------------------------------------
% PROMPT-RETURN LONGITUDE
% Input1: none
% Output1: longitude

%%
while (1)
    longitude = input('Enter longitude [in degrees, -180(west) to +180(east)] :');
    if (abs(longitude) <= 180)
        break
    end
end
