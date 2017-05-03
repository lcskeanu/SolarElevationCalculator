% Keanu Lee Chip Sao & Daniel Mondot
% 3/23/2017
% NASA PROJECT 1
clear all; clc; close all; format short;

%% Solar Elevation Angle Function

disp('Solar elevation angle calculator');
% part 1(a)
if (0)                % Daniel thing
    dayOfYear = 81;   % about January 1st
    altitude = 25;    % 25 km
    latitude = 40;    % 40 degrees north
    longitude = -86;  % 86 degrees west
    TimeZone = -5;    % EST time-zone
else
    disp('Please enter the foollowing values to plot of solar elevation');
    dayOfYear = getDayOfYear(); % get day of year
    altitude = input('Enter altitude in Km:'); % no checking needed
    latitude = getLatitude();
    longitude = getLongitude();
    TimeZone = getTimeZone(); % time zone in hours
end
% get sun rise, sunset, and meridian passage times in local hours
[sunrise sunset M] = getSunTimes(altitude, latitude, longitude, dayOfYear, TimeZone);

% Calculate solar elevation
% divide daylight in 100 entries
times = linspace( sunrise, sunset, 200);

%  first calculate solar declination
d = (dayOfYear-1) * 360 / 365.2425;% Angular Fraction of a Year (d)
l = d + 279.9348;                  % Declination of Earth
sigma = l + 0.4087*sind(l) + ...   
    1.8724*cosd(l) ...
    - 0.0182*sind(2*l) + ... 
    0.0083*cosd(2*l);              % calculate sigma
sin_d = sind(23.437) *sind(sigma); % calculate 'sin D'
cos_d = cosd( asind(sin_d) );      % calculate 'sin alpha'
L = longitude/15;                  % convert from degrees to hours.

% calculate elevation angles for evey minute of a day
for index = 1:length(times)
    %solar hour angle
    solarHourAngle = (times(index) - M + L - TimeZone)*15; % from hours to degrees from GMT
    % calculate sin alpha
    sin_a = sind(latitude)*sin_d + cosd(latitude) * cos_d * cosd(solarHourAngle);
    alpha(index) = asind(sin_a); % get solar elevation angle
end

ptitle = sprintf( ...
    'Solar elevation from \nat altitude=%.2fKm latitude=%.2f longitude=%.2f', ...
    altitude, latitude, longitude);

fig1 = figure(1);
hold on
plot(times, alpha, 'b');
%plot(times, 100*sinax, 'r');
%plot(times, shax, 'g');
hold off
title(gca, ptitle);
xlabel(gca, 'Time of day');
ylabel(gca, 'Elevation in degrees');
grid on

%%
% Part 1(b)
% days in a month
dayOfMonth = [31 28 31 30 31 30 31 31 30 31 30 31]; 

% create data file
foo = fopen ('SolarElevation.tsv', 'wt');
if (foo<0)
    disp('Error: unable to create datafile.tsv');
else
    % Title
    fprintf(foo, '%s\n\n', ptitle);
    fprintf(foo, 'Day\t== Time ==\tSolar Elevation\n');
    day = 1;
    month = 1;
    for index=1:365
        % sunrise, sunset and noon times.
        [sunrise sunset M] = getSunTimes(altitude, latitude, longitude, index, TimeZone);
        % sin_d / cos_d for
        d = (index-1) * 360 / 365.2425;
        l = d + 279.9348;
        % sigma
        sigma = l + 0.4087*sind(l) + 1.8724*cosd(l) - 0.0182*sind(2*l) + 0.0083*cosd(2*l);
        sin_d = sind(23.437) *sind(sigma); % calculate 'sin D'
        % sin 'alpha'
        cos_d = cosd( asind(sin_d) );

        % Instervals from sunrise to sunset
        nh = ceil(sunset - sunrise);
        % 1 hour intervals per day
        timeDay = linspace(sunrise, sunset, nh+1);
        for idy=1:length(timeDay)-1
            % Average time in the next time interval
            averageTime = (timeDay(idy)+ timeDay(idy+1))/2;
            % Elevation angle
            % Hours to degrees from GMT
            solarHourAngle = (averageTime - M + L - TimeZone)*15; 
            % Sin alpha
            sin_a = sind(latitude)*sin_d + cosd(latitude) * cos_d * cosd(solarHourAngle);
            % Solar elevation angle
            elevation = asind(sin_a);
            % Decimal to h:m:s
            hour = floor(timeDay(idy));
            tmp = 60 * (timeDay(idy) - hour);
            minute = floor(tmp);
            second = floor(60 * (tmp - minute) + 0.5);
            fprintf(foo, '%02u-%02u\t%02u:%02u:%02u\t%+07.3f°\n', ...
                month, day, hour, minute, second, elevation);
        end
        % Next Day
        day = day + 1;
        if (day>dayOfMonth(month))
            day = 1;
            month = month+1;
        end
    end

    if (fclose(foo) == 0)
        disp('SolarElevation.tsv succesfully created.');
    end
end



