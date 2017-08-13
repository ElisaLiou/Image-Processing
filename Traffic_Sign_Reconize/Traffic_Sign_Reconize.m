clc, clear, close all

%set screen
figure(1)
set(gcf,'Position',[200,100,1000,500]); %set screen size
h=getframe(1);


%Read image
[filename, pathname, filterindex]  = uigetfile({'*.png';'*.jpg'},'Select an image');
source.img = imread([pathname filename]);
info=imfinfo(filename);
source.colortype=info.ColorType;

% noise
source.img=imnoise(source.img,'salt & pepper',0.03);

subplot(2,5,1);
imshow(source.img);
title(['Query image']);

%saperate RGB
r = source.img(:,:,1);
g = source.img(:,:,2);
b = source.img(:,:,3);

%casting
I = double(source.img);
R = double(r);
G = double(g);
B = double(b);

%up-down
%mean
Rmean=mean(R);
Gmean=mean(G);
Bmean=mean(B);

%reshape
columnRreshape=reshape(Rmean,10,length(Rmean)/10);
columnGreshape=reshape(Gmean,10,length(Gmean)/10);
columnBreshape=reshape(Bmean,10,length(Bmean)/10);

%reshape mean
columnRrmean=mean(columnRreshape);
columnGrmean=mean(columnGreshape);
columnBrmean=mean(columnBreshape);


%left-right
%rotate
rotR=rot90(R);
rotG=rot90(G);
rotB=rot90(B);

%mean
rotRmean=mean(rotR);
rotGmean=mean(rotG);
rotBmean=mean(rotB);

%reshape
rowRreshape=reshape(rotRmean,10,length(rotRmean)/10);
rowGreshape=reshape(rotGmean,10,length(rotGmean)/10);
rowBreshape=reshape(rotBmean,10,length(rotBmean)/10);

%reshape mean
rowRrmean=mean(rowRreshape);
rowGrmean=mean(rowGreshape);
rowBrmean=mean(rowBreshape);

%rotateback
rotrowRrmean=rot90(rowRrmean);
rotrowGrmean=rot90(rowGrmean);
rotrowBrmean=rot90(rowBrmean);

n=sum(columnRrmean)+sum(columnGrmean)+sum(columnBrmean)+sum(rotrowRrmean)+sum(rotrowGrmean)+sum(rotrowBrmean);

%dataset
srcFiles = dir('dataset\*.png');  % the database folder
for i = 1 : length(srcFiles) %read every image in folder
    filename = strcat('dataset\',srcFiles(i).name); %path
    database.img = imread(filename);
    
    %database
    %saperate RGB
    dbr = database.img(:,:,1);
    dbg = database.img(:,:,2);
    dbb = database.img(:,:,3);

    %casting
    dbI = double(database.img);
    dbR = double(dbr);
    dbG = double(dbg);
    dbB = double(dbb);

    %up-down
    %mean
    dbRmean=mean(dbR);
    dbGmean=mean(dbG);
    dbBmean=mean(dbB);

    %reshape
    dbcolumnRreshape=reshape(dbRmean,10,length(dbRmean)/10);
    dbcolumnGreshape=reshape(dbGmean,10,length(dbGmean)/10);
    dbcolumnBreshape=reshape(dbBmean,10,length(dbBmean)/10);

    %reshape mean
    dbcolumnRrmean=mean(dbcolumnRreshape);
    dbcolumnGrmean=mean(dbcolumnGreshape);
    dbcolumnBrmean=mean(dbcolumnBreshape);


    %left-right
    %rotate
    dbrotR=rot90(dbR);
    dbrotG=rot90(dbG);
    dbrotB=rot90(dbB);

    %mean
    dbrotRmean=mean(dbrotR);
    dbrotGmean=mean(dbrotG);
    dbrotBmean=mean(dbrotB);

    %reshape
    dbrowRreshape=reshape(dbrotRmean,10,length(dbrotRmean)/10);
    dbrowGreshape=reshape(dbrotGmean,10,length(dbrotGmean)/10);
    dbrowBreshape=reshape(dbrotBmean,10,length(dbrotBmean)/10);

    %reshape mean
    dbrowRrmean=mean(dbrowRreshape);
    dbrowGrmean=mean(dbrowGreshape);
    dbrowBrmean=mean(dbrowBreshape);

    %rotateback
    dbrotrowRrmean=rot90(dbrowRrmean);
    dbrotrowGrmean=rot90(dbrowGrmean);
    dbrotrowBrmean=rot90(dbrowBrmean);   
    
    %database n
    dbn=sum(dbcolumnRrmean)+sum(dbcolumnGrmean)+sum(dbcolumnBrmean)+sum(dbrotrowRrmean)+sum(dbrotrowGrmean)+sum(dbrotrowBrmean);
    
    %database n- n
    result(i)=[abs(dbn-n)];
end

%the top five similar
SortResult=sort(result,'ascend');
for i=1:5 
   col=find(result==SortResult(i)); %find what the file is
   findfile=strcat('dataset\',srcFiles(col).name); %set the path
   
   %printout
   subplot(2,5,i+5);
   imshow(imread(findfile));
   title(['Top' num2str(i) ' (' num2str(SortResult(i)) ')']);
end


