function TimeZone = getTimeZone()
%--------------------------------------------------------------------------
% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 2
%--------------------------------------------------------------------------
% PROMPT-RETURN TIME ZONE
% Input1: none
% Output1: timezone - given in hours from -12 to 12.

%% 
while (1)
   TimeZone = input('Enter timezone [e.g. EST = -5)] :');
    if (abs(TimeZone) <= 12)
        break
    end
end
