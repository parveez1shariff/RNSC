clear all;
close all;


folder='E:\Matlab Program\Programs\RNSC\Rainfall NC';
filetype='*.nc';  % or xlsx
f=fullfile(folder,filetype);
d=dir(f);
for k=1:numel(d);
  fullfile(folder,d(k).name)
  rainlat =  ncread(fullfile(folder,d(k).name),'lat');
  rainlog =  ncread(fullfile(folder,d(k).name),'lon');
  rainrec = ncread(fullfile(folder,d(k).name),'RF');

% rainlat = xlsread('rainfall data.xlsx',2);
% rainlog = xlsread('rainfall data.xlsx',3);
% rainrec = xlsread('rainfall data.xlsx',4);

rainval = rainlat(:,1);
rain_latval = rainlat(:,1);
rain_logval = rainlog(:,1);

latr = [];
for i = 1:length(rainval)
    if(rainval(i)>=13.125 && rainval(i)<=15.375)
        latr(i) = i;          
    end
    
end

rainlogval = rainlog(:,1);

logr = [];
for i = 1:length(rainlogval)
    if(rainlogval(i)>=77.625 && rainlogval(i)<=80.125)
        logr(i) = i;
    end
end

latr = nonzeros(latr)';
logr = nonzeros(logr)';
% if isequal(size(latr),size(logr))
%     c = [latr;logr];
% elseif (length(latr)<length(logr))
%     latr = ([latr ones(1,(length(logr)-length(latr)))])
% end
    
rain_recval = [];%zeros(length(latr),length(logr));
date=d.name
c1 = strrep(date,'CDAS_IMD_RF_15MIN_',' ');
c2 = c1(1:9);
c1 = [c2(1:5),'/',c2(6:7),'/',c2(8:9)];
%rain_recval=num2str(date)
rain_recval=cellstr(c1)
for r = 1:length(latr)
     rain_recval{r+1,1}= rainlat([latr(r)])'
end
for c = 1:length(logr)
     rain_recval{1,c+1}= rainlog([logr(c)])'
end
for r = 1:length(latr)
   for c = 1:length(logr)
        rain_recval{r+1,c+1} = rainrec([latr(r)], [logr(c)]);
    end
end


close all;
% figure(); 
% surfl(rain_recval)
% colormap(jet)    % change color map
% shading interp

% figure();
% plot(rain_recval);

path = 'E:\Matlab Program\Programs\RNSC\Rainfall Extracted_NC';
%filename = 'rainfall_Extracted.xlsx';
filename = [path, filesep, 'Rainfall_Extract_NC',num2str(k)] ;

xlswrite(filename,rain_recval);
disp(filename)
end

