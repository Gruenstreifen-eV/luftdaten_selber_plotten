clear all; close all; clc;


sensor_id = "16633401"; % SensorID


files = ls(['*',sensor_id,'*.csv']);


% Initialisierung
datum = [];
uhrzeit = [];
PM100 = [];
PM025 = [];

for i=1:size(files,1)
  datfile = files(i,:)
  [tmp1 tmp2 tmp3 tmp4] = textread(datfile,"%s %s;;;;;;;%f;%f;%*","headerlines",1);
  datum = [datum; tmp1]; 
  uhrzeit = [uhrzeit;tmp2];
  PM100 = [PM100;tmp3];
  PM025 = [PM025;tmp4];
endfor

for i=1:length(datum)
  [year(i), month(i), day(i)]= strread(datum{i},"%f/%f/%f");
  [hour(i), minute(i), second(i)]= strread(uhrzeit{i},"%f:%f:%f");
endfor

t = datenum(year,month,day,hour,minute,second) + 2/24;


% Daten speichern (im Moment nur Feinstaub, muss noch um T und H ergänzt werden)
data = [t' PM025 PM100];
save_file = [num2str(sensor_id),'.mat'];
save(save_file,'data');

