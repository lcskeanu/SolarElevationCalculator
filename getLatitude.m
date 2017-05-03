function latitude = getLatitude()
%--------------------------------------------------------------------------
% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 2
%--------------------------------------------------------------------------
% PROMPT-RETURN LATITUDE
% Input1: none
% Output1: latitude

%%
while (1)
    latitude = input('Enter latitude in degrees (South Pole=-90°, North Pole=+90°) :');
    if (abs(latitude) <= 90)
        break
    end
end
