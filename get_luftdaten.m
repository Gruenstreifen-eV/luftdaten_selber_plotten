clear all; close all; clc;

date_0 = '2018-05-01';  % Datum der ersten Messung
sensor_id = "16633401"; % SensorID

i1 = datenum(date_0);
i2 = datenum(datestr(date(),29)); % Aktuelles Datum

for i = i1:i2
      localfile = ['data-esp8266-',sensor_id,'-',datestr(i,29),'.csv'];
      url = ['https://www.madavi.de/sensor/data/',localfile];
      status= urlwrite(url,localfile);
endfor