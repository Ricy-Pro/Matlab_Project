clc

a = imread('ss.png');

b = rgb2gray(a);

c = 255-b;

d = imbinarize(c);


e = imfill(d,'holes');
ses=strel('disk',2);
e1=imclose(e,ses);

f = bwlabel(e1);
vislabels(f),title('each object labelled')
g = regionprops(f,'Area','BoundingBox');
g(1)
area_values = [g.Area];
idx = find((7000 <= area_values) & (area_values <= 9000));

h = ismember(f,idx);
vmax=0;
j=1;


%aria
nr=max(max(f));
for i=1:max(max(f))
v(i)=bwarea(f==i);
if vmax<v(i)
    vmax=v(i);
    j=i;
    
    %coloram obiectul cu cea mai mare arie
po=f==j;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=255;
G(~po)=255;
B(~po)=255;
op1=cat(3,R,G,B);
edgeImage(~op1)=255;

end
end
%perimetru
se=ones(3,3);
amax=1000000;
for i=1:max(max(f))
x=f==i;
sq=imerode(x,se);
p=x-sq;
s(i)= bwarea(p);
   
if amax>s(i) && s(i)>50
    amax=s(i);
    k=i;
end
end
%coloram obiectul cu cel mai mic perimetru
po=f==k;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=255;
G(~po)=255;
B(~po)=255;
op2=cat(3,R,G,B);
edgeImage(~op2)=255;

%afisam 
Z1=cat(2,op1,op2);
figure, imshow(Z1);

%luminozitate
maxceva=0; minceva=1000000000000;
for i=1:nr
po=f==i;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=0;
G(~po)=0;
B(~po)=0;
ceva=cat(3,R,G,B);
edgeImage(~ceva)=0;
%ceva1 imaginea gri , ceva 2 imaginea neagra
ceva1=im2gray(ceva);
ceva2=im2bw(ceva);
%nblack retine nr pixelii negrii
nblack=sum(ceva2(:));
%nwhite retine nr pixelii albi
nwhite=numel(ceva2)-nblack;
%calculam nr total pixeli
[pixelCounts, grayLevels] = imhist(ceva1);
numberOfPixels = sum(pixelCounts);
%calculam luminozitatea ca fiind raportul dintre suma valorilor de culoarea
%pixelilor si numarul total de pixeli din imagine

brightness=sum(ceva(:))/(numberOfPixels-nwhite);

if minceva>brightness
    minceva=brightness;
    w=i;
    disp(w);
    
    
end
if maxceva<brightness
    maxceva=brightness;
    y=i;
    
end


end
%afisam cel mai intunecat
po=f==w;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=255;
G(~po)=255;
B(~po)=255;
op3=cat(3,R,G,B);
edgeImage(~op3)=0;

%afisam cel mai luminos
po=f==y;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=255;
G(~po)=255;
B(~po)=255;
op4=cat(3,R,G,B);
edgeImage(~op4)=0;

Z2=cat(2,op3,op4);
figure;imshow(Z2);






    %aflam elementele asimetrice
      blankimage = ones(size(a,1),size(a,2),size(a,3));
        figure(12);
       fin=blankimage;
for i=1:nr
ok=1;
% centram obiectele, le facem inversul(sus,jos)(stanga,dreapta) sustragem
% din imaginea initiala 
    bw = f==i;
    bw = double(bw);
    bw = im2bw(bw);
    sz_bw = size(bw);
    state_bw = regionprops(bw,'Centroid');
    cm = centerobject(bw);
    sz_cm = size(cm);
    state_cm = regionprops(cm,'Centroid');
    intros=flip(cm);
    dif=imsubtract(uint8(cm),uint8(intros));
    dif1=imsubtract(uint8(cm),uint8(fliplr(cm)));
    sum(dif(:))
    sum(dif1(:))
    if sum(dif(:))<100 || sum(dif1(:))<100
   ok=0;
    end
   

    if ok==1 
       
fin=imfuse(fin,f==i);
fin=rgb2gray(fin);
po=fin;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=255;
G(~po)=255;
B(~po)=255;
final=cat(3,R,G,B);
edgeImage(~final)=255;





       end
end
imshow(final);



%ordonare descrecatoare in vector
for i=1:nr
    for i2=i:nr
      
      
       
        if v(i2)>v(i)
            aux=v(i);
            v(i)=v(i2);
            v(i2)=aux;
          
        end
    end
  
    
end
i=1;
z2=f==2;
bs=0;
fin2=blankimage;

%afisam descrecator obiectele
while i<=nr

for i2=1:nr
    t=bwarea(f==i2);
    
    if t==v(i)

    
po=f==i2;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=255;
G(~po)=255;
B(~po)=255;
mask1=cat(3,R,G,B);
edgeImage(~mask1)=255;
if bs==0;
    fin2=imfuse(fin2,mask1);
    bs=1;
fin2=im2gray(fin2);
po=fin2;
bin3dms=repmat(po,1,1,3);
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R(~po)=255;
G(~po)=255;
B(~po)=255;
fin2=cat(3,R,G,B);
edgeImage(~fin2)=255;
end
fin2=cat(2,fin2,mask1);



     i=i+1;
     break
end
end
end
figure;
imshow(fin2);