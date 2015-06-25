function yes = pcplot(list)

% This function find the principal components of the landscape vectors, find
% the center of each image type, connects the center to each instance, and
% colors each "cluster" in a unique color. 
dir1=strcat(pwd,'/nonrigid3d');
addpath(dir1);
files = dir(strcat(dir1,'/*.plv'));

shape=load(files(1).name);
p=length(shape); 
n=length(files); 
h = zeros(p,n);  


% { 1.cat, 2.centaur, 3.david, 4.dog, 5.gorilla, 6.horse, 7.lioness, 8.michael,
% 9.seahorse, 10.shark, 11.victoria, 12.wolf}
set=list;

% vector matrix:h. simultaneously strip filename to image type for
% labeling purposes.
for i = 1:length(files)
    h(:,i) = load(files(i).name);
    w=regexp(files(i).name,'\d*','match');
    w=strcat(w,'.plv');
    files(i).name=strrep(files(i).name,w,'');
end

% find unique images and indices. ref: doc unique
t=[files.name];
[a,b,c]=unique(t,'legacy');

% find correlation matrix of h
h = h';
sigma = cov(h);
Corr = corrcov(sigma);

% finds eigenpairs of Corr
[vec,lambda]=eig(sigma);

% first two eigenvectors with highest e.value are last two
p1=vec(length(vec)-1,:)';
p2=vec(length(vec)-2,:)';

% principal components. output corresponding variance
y1=p1'*h';
y2=p2'*h';
t=diag(lambda);
variance = sum(t(length(t)-2:length(t)))/sum(t);
disp(['The principal components capture ' num2str(variance) ' of the total variance']);

%find center using unique function above
center=zeros(2,length(b));
center(:,1)=[mean(y1(1:9)),mean(y2(1:9))]';
for j=2:length(b)
  center(:,j)=[mean(y1(b(j-1)+1:b(j))),mean(y2(b(j-1)+1:b(j)))];
end
a
%plots each cluster, colors, and labels center
colors=colorrr(length(b));
figure
for j = set
    if j == 1
        for k = 1:b(1)
            plot([center(1,c(k));y1(k)], [center(2,c(k));y2(k)],'-k','color',colors(c(k),:),'LineWidth',1.2)
            hold on
        end
    else
        for k=b(j-1)+1:b(j)
            plot([center(1,c(k));y1(k)], [center(2,c(k));y2(k)],'-k','color',colors(c(k),:),'LineWidth',1.2);
            hold on
        end
    end
end
        

for j = set
    text(center(1,j),center(2,j),files(b(j)).name,'FontSize', 24);
end