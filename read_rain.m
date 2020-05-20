clear all;
close all;

folder='E:\Matlab Program\Programs\RNSC\rainfall';
filetype='*.xlsx';  % or xlsx
f=fullfile(folder,filetype);
d=dir(f);
for k=121:numel(d);
  rainlat = xlsread(fullfile(folder,d(k).name),2);
  rainlog = xlsread(fullfile(folder,d(k).name),3);
  rainrec = xlsread(fullfile(folder,d(k).name),4);

% rainlat = xlsread('rainfall data.xlsx',2);
% rainlog = xlsread('rainfall data.xlsx',3);
% rainrec = xlsread('rainfall data.xlsx',4);

rainval = rainlat(:,2);
rain_latval = rainlat(:,1);
rain_logval = rainlog(:,1);

latr = [];
for i = 1:length(rainval)
    if(rainval(i)>=13.125 && rainval(i)<=15.375)
        latr(i) = rainlat(i);          
    end
    
end

rainlogval = rainlog(:,2);

logr = [];
for i = 1:length(rainlogval)
    if(rainlogval(i)>=77.625 && rainlogval(i)<=80.125)
        logr(i) = rainlog(i);
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
for r = 1:length(latr)
     rain_recval(r+1,1)= rainlat([latr(r)],2)'
end
for c = 1:length(logr)
     rain_recval(1,c+1)= rainlog([logr(c)],2)'
end

for r = 1:length(latr)
    for c = 1:length(logr)
        rain_recval(r+1,c+1) = rainrec([latr(r)], [logr(c)]);
    end
end

close all;
figure(); 
surfl(rain_recval)
% colormap(jet)    % change color map
% shading interp

figure();
plot(rain_recval);

path = 'E:\Matlab Program\Programs\RNSC\Rainfall Extracted';
%filename = 'rainfall_Extracted.xlsx';
filename = [path, filesep, 'Rainfall_Extract',num2str(k)] ;
xlswrite(filename,rain_recval);
disp(filename)
end
