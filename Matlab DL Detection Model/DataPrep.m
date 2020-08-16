%Extracting boundingbox + sourceInfo from .csv -> Creating ground truth object w/ Feugo Dataset
% ***Original Images***

%test boundingbox format
% I = imread('bh-w-mobo-c__2019-06-10T13;26;16.jpg');
% imshow(I);
% 
% hold on
% rectangle('Position', [547 974 608-547 1007-974],...
%   'EdgeColor','r', 'LineWidth', 3);

% .csv -> .mat format
% [xmin,ymin,xmax,ymax] -> [xmin,ymin,w,h]

T = readtable('2019a-bounding-boxes.csv');


%append full directory for smoke data 

imageFilenames = T(1:end,5);
imageFilenames = table2struct(imageFilenames);
imageFilenamesCopy = imageFilenames;

files = dir(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images','*.jpg'));

%find copies within csv list
for i = 1:size(imageFilenames, 1)
   match = 0;
   for j = i+1:size(imageFilenames,1)
       if strcmp(imageFilenames(i).Filename, imageFilenames(j).Filename) 
          match = 1;
          break
       end
   end
   if match
       imageFilenamesCopy(i).Filename = [];
       
       %toremove = rowfun(@(varargin) isempty([varargin{:}]), T, 'ExtractCellContents', true);
       T(i, :) = [];
       
   end
end

imageFilenames = T(1:end,5);
imageFilenames = table2struct(imageFilenames);
imageFilenamesCopy = imageFilenames;

%find missing files
n = 0;
match = 0;

for i = 1:size(imageFilenames, 1)
   match = 0;
   for j = 1:size(files,1)
       if strcmp(imageFilenames(i).Filename, files(j).name) 
          match = 1;
          break
       end
   end
   if ~match
       imageFilenamesCopy(i).Filename = [];
       
       T(i, :) = [];
   end
end

minx = T(1:end,1);
miny = T(1:end,2);
maxx = T(1:end,3);
maxy = T(1:end,4);
minx = table2array(minx);
miny = table2array(miny);
maxx = table2array(maxx);
maxy = table2array(maxy);


w = maxx - minx;
h = maxy - miny;

imageFilenamesFixed = T(1:end,5);
imageFilenamesFixed = table2cell(imageFilenamesFixed);

dataSource = groundTruthDataSource(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images',imageFilenamesFixed));

%define labels specifying gtruth

ldc = labelDefinitionCreator();
addLabel(ldc,'smoke',labelType.Rectangle);
labelDefs = create(ldc);

C = {minx miny w h};
C = cell2mat(C);

labelNames = {'smoke'};
labelData = table(C,'VariableNames',labelNames);

gTruth = groundTruth(dataSource, labelDefs, labelData); %correct gTruth object /checked/loaded via image labelling app


