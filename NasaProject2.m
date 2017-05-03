% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 2
clear all; clc; close all; format short;
%% part 2(a)

% Testing external functions
disp('Sunrise / Sunset times calculator');

if (0)                % Default (Daniel thing)
    altitude = 25;    % default 25km
    latitude = 40;    % 40 degrees north
    longitude = -86;  % 86 degrees west
    TimeZone = -5;    % EST time-zone
else
    disp('Sunrise/Sunset Calculator:');
    altitude = input('Enter altitude in Km:');
    latitude = getLatitude();
    longitude = getLongitude();
    TimeZone = getTimeZone();
end
dayOfYear = linspace(1, 365, 365);
for index = 1:365
    [srise sset M] = getSunTimes(altitude, latitude, longitude, index, TimeZone);
    sunrise(index) = srise;
    sunset(index) = sset;
end
% Plot graph
fig1 = figure(2);
hold on; plot(dayOfYear, sunrise, 'r'); plot(dayOfYear, sunset, 'g'); hold off
ptitle = sprintf( 'Sunset & Sunrise \n Altitude=%.2fKm Latitude=%.2f Longitude=%.2f', ...
    altitude, latitude, longitude);
title(gca, ptitle); xlabel(gca, 'Day of year'); ylabel(gca, 'Time in hours');
legend('sunrise time', 'sunset time', 'location', 'East');
grid on; xlim([1 365]); ylim([2 22]);

% Days in Month
set(gca,'XTick',[1, 32 60 91 121 152 182 213 244 274 305 335]);
set(gca,'YTick',[2 3 4 5 6 7 8 12 16 17 18 19 20 21 22]);
% Months
onthString=['   Jan'; '   Feb'; '   Mar'; '   Apr'; '   May'; '   Jun'; ...
     '   Jul'; '   Aug'; '   Sep'; '   Oct'; '   Nov'; '   Dec'];
set(gca,'xticklabel',onthString);

%%
%part 2(b)
% 'wt' converts \n into \r\n, so that notepad can read it.
foo = fopen ('SunsetSunrise.tsv', 'wt');
if (foo<0)
    disp('Error: unable to create datafile.tsv');
else
    % Title
    fprintf(foo, '%s\n\n', ptitle);
    fprintf(foo, 'Day\tSunrise\t\tSunset\n');

    day = 1;
    month = 1;
    dayOfMonth = [31 28 31 30 31 30 31 31 30 31 30 31]; % Day in Month
    for index=1:365
        %convert decimal times into h:m:s
        %sunrise
        hour0 = floor(sunrise(index));
        tmp = 60 * (sunrise(index) - hour0);
        minute0 = floor(tmp);
        second0 = 60 * (tmp - minute0);
        %sunset
        hour1 = floor(sunset(index));
        tmp = 60 * (sunset(index) - hour1);
        minute1 = floor(tmp);
        second1 = 60 * (tmp - minute1);
        fprintf(foo, '%02u-%02u\t%02u:%02u:%06.3f\t%02u:%02u:%06.3f\n', ...
            month, day, hour0, minute0, second0, hour1, minute1, second1);
        day = day + 1;
        if (day>dayOfMonth(month))
            day = 1;
            month = month+1;
        end
    end
    if (fclose(foo) == 0)
        disp('SunsetSunrise.tsv succesfully created.');
    end
end

