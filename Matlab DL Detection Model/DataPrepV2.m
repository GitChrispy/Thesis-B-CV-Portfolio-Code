%Using Resized Feugo Dataset [416 x 416]

%Extract boundingbox + sourceInfo from .csv -> Creating ground truth object

%Resize boundingbox

T = readtable('2019a-bounding-boxes.csv');

imageFilenames = T(1:end,5);
imageFilenames = table2struct(imageFilenames);
imageFilenamesCopy = imageFilenames;

files = dir(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized','*.jpg'));

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

imageFilenamesFixed = T(1:end,5);
imageFilenamesFixed = table2struct(imageFilenamesFixed);

minx = table2array(minx);
miny = table2array(miny);
maxx = table2array(maxx);
maxy = table2array(maxy);


w = maxx - minx;
h = maxy - miny;

outputSize = [416,416];

cd(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images'));
for i = 1:size(imageFilenamesFixed, 1)
    im = imread(imageFilenamesFixed(i).Filename);
    inputSize = size(im);
    inputSize = inputSize(1,1:2);
    a = outputSize(1,2)/inputSize(1,2);
    b = outputSize(1,1)/inputSize(1,1);
    minx(i) = a*minx(i);
    miny(i) = b*miny(i);
    w(i) = a*w(i);
    h(i) = b*h(i);
end

%imageFilenamesFixed = table2cell(imageFilenamesFixed);

imageFilenamesFixed = struct2cell(imageFilenamesFixed);

dataSource = groundTruthDataSource(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized',imageFilenamesFixed)); %416 x 416

%define labels specifying gtruth

ldc = labelDefinitionCreator();
addLabel(ldc,'smoke',labelType.Rectangle);
labelDefs = create(ldc);

C = {round(minx) round(miny) round(w) round(h)};
C = cell2mat(C);

labelNames = {'smoke'};
labelData = table(C,'VariableNames',labelNames);

gTruthResized = groundTruth(dataSource, labelDefs, labelData); %correct gTruth object /checked/loaded via image labelling app


