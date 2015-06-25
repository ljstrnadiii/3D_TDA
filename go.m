% This file will create a corresponding .txt file which stores the
% (tri1,tri2,angle) for every pair of neighboring triangles
dir1=strcat(pwd,'/nonrigid3d/*.tri');
dir2=strcat(pwd,'/nonrigid3d/*.vert');
files1 = dir(dir1);
files2 = dir(dir2);

for k =1:length(files1)
    
    %load triangles and vertices
    tri=load(files1(k).name);
    pt=load(files2(k).name);
    
    % create sparse for angles
    W=sparse(length(tri),length(tri));
   
    %make triangulation of .tri
    tr= TriRep(tri,pt(:,1),pt(:,2),pt(:,3));
    
    for i = 1:length(tri)
        % each triangle i has three neighbors. They get assigned here.
        nbrs=zeros(4,1);
        nbrs(1,1)=i;
        nbrs(2:4,1)=neighbors(tr,i);
        
        %calculate theta between three triangles that share edge with i
        normal1 = cross(pt(tri(nbrs(1),1),:)-pt(tri(nbrs(1),2),:),pt(tri(nbrs(1),1),:)-pt(tri(nbrs(1),3),:));
        for j = 2:4
            if ~isnan(nbrs(j))
                normal2 = cross(pt(tri(nbrs(j),1),:)-pt(tri(nbrs(j),2),:),pt(tri(nbrs(j),1),:)-pt(tri(nbrs(j),3),:));
                theta = acos((dot(normal1,normal2)/(norm(normal1)*norm(normal2))));
                % stores theta between i and three triangles one at a time
                W(i,nbrs(j))=theta; 
            end
        end
 
        %keep sorted as you go
        sort(W(i,:));
    end
    
    % dump theta matrix into txt file and save as filenme.txt
    [i,j,val]=find(W);
    data_dump=[i,j,val];
    l=files1(k).name;
    filename = strrep(l, '.tri','.txt');
    place=strcat(pwd,'/nonrigid3d/',filename);
    dlmwrite(place, data_dump, 'delimiter',' ');
end