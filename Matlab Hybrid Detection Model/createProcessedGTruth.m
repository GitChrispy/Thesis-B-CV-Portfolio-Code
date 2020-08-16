% adapted from Matlab YOLOv2 Testing\DataPrepV2

%given a table of BBoxes related to image names, create a gTruth object for
%object detection training

function gTruth = createProcessedGTruth()
    T = readtable('C:\Users\jusfo\Desktop\Smoke Images\2019a-bounding-boxes.csv');

    imageFilenames = T(1:end,5);
    imageFilenames = table2struct(imageFilenames);
    imageFilenamesCopy = imageFilenames;

    files = dir(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V2\Smoke','*.jpg'));

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

    cd(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Dataset\Fuego Smoke_Images')); %original Fuego sized images which .csv bboxes relate to 
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

    dataSource = groundTruthDataSource(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V2\Smoke',imageFilenamesFixed)); %416 x 416

    %define labels specifying gtruth

    ldc = labelDefinitionCreator();
    addLabel(ldc,'smoke',labelType.Rectangle);
    labelDefs = create(ldc);

    C = [round(minx) round(miny) round(w) round(h)];
    idx = find(C == 0);
    C(idx) = 1; %ensure bbox is within image

    labelNames = {'smoke'};
    labelData = table(C,'VariableNames',labelNames);

    gTruth = groundTruth(dataSource, labelDefs, labelData); %correct gTruth object /checked/loaded via image labelling app
end