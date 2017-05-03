function dayOfYear = getDayOfYear()
%--------------------------------------------------------------------------
% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 2
%--------------------------------------------------------------------------
% RETURN DAY OF YEAR
% Input1: none
% Output1: dayOfYear - Day Of Year

%% 
dayOfMonth = [31 28 31 30 31 30 31 31 30 31 30 31]; % days in a month
while (1)
    date = input('Enter date (mm-dd-yyyy):', 's');
    % check that day is valid
    [val cnt] = sscanf(date, '%u-%u-%u');
    if (cnt <3) continue;
    end
    month  = val(1);
    day  = val(2);
    year = val(3);
    if ((month>12) || (month<1) ) continue;
    end
    if (mod(year,4) == 0)
        dayOfMonth(2) = 29; % Leap year test
    else
        dayOfMonth(2) = 28; % Non leap year
    end
    if ((day >dayOfMonth(month)) || (day<1)) continue;
    end
    if ((year>=2000) && (year<=2100)) break;
    end
end
dayOfYear = day;
for m=1:month-1
    dayOfYear = dayOfYear + dayOfMonth(m);
end
