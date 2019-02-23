clear all; close all; clc;

sensor_id = "16633401"; % SensorID

% definiere Plotintervall
tag_start = datenum(2019,02,13,00,00,00)
tag_ende  = datenum(2019,02,20,00,00,00)

fs = 16; % FontSize

file_name = [num2str(sensor_id),'.mat'];

load(file_name,'data');

t = data(:,1);
PM025 = data(:,2);
PM100 = data(:,3);


% NANs rausschmeißen
[i1,j] = find(isnan(PM100));
[i2,j] = find(isnan(PM025));
[i3,j] = find(isnan(t));
i = [i1; i2; i3];
PM100(i) = [];
PM025(i) = [];
t(i) = [];






tag(1) = tag_start;
for  i = 1:tag_ende-tag_start
  tag(i+1) = tag(i)+1;
endfor


figure('Position',[0 0 1200 800]);
h1=plot(t,PM100,'b.'); hold on;
h2=plot(t,PM025,'r.');
axis([tag_start tag_ende 0 60]);
title('Feinstaub - zeitlicher Verlauf','FontSize',fs);
set(gca,'XTick',tag);
set(gca,'xticklabel',datestr(tag,'dd.mm.'));
grid on;
xlabel('Datum','FontSize',fs);
ylabel('{Konzentration in µg/m³}','FontSize',fs,'interpreter','tex');
h = legend([h1,h2],'{\color{blue} PM10}','{\color{red} PM2.5}');
set(gca,'FontSize',fs);
set(h, "fontsize", fs);




