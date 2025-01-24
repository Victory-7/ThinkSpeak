% Setup ThingSpeak parameters
channelID = 123456; % Replace with your ThingSpeak Channel ID
readAPIKey = 'YOUR_READ_API_KEY'; % Replace with your Read API Key
writeAPIKey = 'YOUR_WRITE_API_KEY'; % Replace with your Write API Key

% Read the last 10 data points from ThingSpeak
data = thingSpeakRead(channelID, 'Fields', [1, 2, 3], 'NumPoints', 10, 'ReadKey', readAPIKey);

% Extract data
temperature = data(:, 1); % Field 1: Temperature
humidity = data(:, 2);    % Field 2: Humidity
pressure = data(:, 3);    % Field 3: Pressure

% Check if data exists
if isempty(temperature) || isempty(humidity) || isempty(pressure)
    error('No data available in the ThingSpeak channel.');
end

% Data Processing
avgTemp = mean(temperature); % Average Temperature
avgHumidity = mean(humidity); % Average Humidity
avgPressure = mean(pressure); % Average Pressure

% Detect anomalies (e.g., temperature > 50°C)
anomalies = temperature > 50;

% Display results
fprintf('Average Temperature: %.2f °C\n', avgTemp);
fprintf('Average Humidity: %.2f %%\n', avgHumidity);
fprintf('Average Pressure: %.2f hPa\n', avgPressure);
if any(anomalies)
    fprintf('Anomaly Detected: High Temperature Recorded.\n');
end

% Visualization
figure;
subplot(3, 1, 1);
plot(temperature, '-o');
title('Temperature Data');
xlabel('Time Points');
ylabel('Temperature (°C)');

subplot(3, 1, 2);
plot(humidity, '-o');
title('Humidity Data');
xlabel('Time Points');
ylabel('Humidity (%)');

subplot(3, 1, 3);
plot(pressure, '-o');
title('Pressure Data');
xlabel('Time Points');
ylabel('Pressure (hPa)');

% Optional: Write processed data back to ThingSpeak
thingSpeakWrite(channelID, 'Fields', [avgTemp, avgHumidity, avgPressure], 'WriteKey', writeAPIKey);

disp('Processed data has been written back to ThingSpeak.');
