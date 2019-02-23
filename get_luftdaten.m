clear all; close all; clc;

sensor_id = "16633401"; % SensorID

% Beginn der Messungen ---
jahr_0 = 2018;
monat_0 = 04;
tag_0 = 01;
% ------------------------

% aktuelles Datum -----------------
jahr_aktuell = str2num(datestr(date(),10))
monat_aktuell = str2num(datestr(date(),5))
tag_aktuell = str2num(datestr(date(),7))
% ----------------------------------

% Alle Daten der Vormonate sind in zip-Dateien gespeichert,
% ergo: Download der zip Dateien
% 1. für das allererste Jahr (vermutlich unvollst. Monate)
if jahr_aktuell > jahr_0
 for monat = monat_0:12
  localfile = ['data-esp8266-',sensor_id,'-',sprintf("%d",jahr_0),'-',sprintf("%02d",monat),'.zip'];
  url = ['https://www.madavi.de/sensor/data_csv/',sprintf("%d",jahr_0),'/',sprintf("%02d",monat),'/',localfile];
  status= urlwrite(url,localfile);
  unzip(localfile); % zip Datei auspacken
  delete(localfile); % zip Datei löschen
 endfor
endif
% 2. für die Jahre nach dem ersten Jahr aber vor dem aktuellen Jahr
for jahr=jahr_0+1:jahr_aktuell-1
 for monat = 1:12
  localfile = ['data-esp8266-',sensor_id,'-',sprintf("%d",jahr),'-',sprintf("%02d",monat),'.zip'];
  url = ['https://www.madavi.de/sensor/data_csv/',sprintf("%d",jahr),'/',sprintf("%02d",monat),'/',localfile];
  status= urlwrite(url,localfile);
  unzip(localfile); % zip Datei auspacken
  delete(localfile); % zip Datei löschen
 endfor
endfor
% 3. für das aktuelle Jahr bis zum vergangenen Monat
for monat = 1:monat_aktuell-1
 localfile = ['data-esp8266-',sensor_id,'-',sprintf("%d",jahr_aktuell),'-',sprintf("%02d",monat),'.zip'];
 url = ['https://www.madavi.de/sensor/data_csv/',sprintf("%d",jahr_aktuell),'/',sprintf("%02d",monat),'/',localfile];
 status= urlwrite(url,localfile);
 unzip(localfile); % zip Datei auspacken
 delete(localfile); % zip Datei löschen
endfor

% Und zum Schluss die Daten des aktuellen Monats
for tag = 1:tag_aktuell
 localfile = ['data-esp8266-',sensor_id,'-',sprintf("%d",jahr_aktuell),'-',sprintf("%02d",monat_aktuell),'-',sprintf("%02d",tag),'.csv'];
 url = ['https://www.madavi.de/sensor/data_csv/',localfile];
 status= urlwrite(url,localfile);
endfor
