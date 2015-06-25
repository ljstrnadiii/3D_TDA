% Percentile will introduce the triangles in the image by largest to 
%   smallest angle. i.e. the lower percentile the more the image will fill.
addpath('/Users/len/Desktop/Classes/Topology/3D_TDA_Classification/JavaPlex_Project');
% load whatever file type from directory: theta is 3
pts=load('cat0.vert');
tri=load('cat0.tri');
theta=load('cat0.txt');
length(theta)

% looks at percentile by angle
percentile = .9 ;
prob = 1- percentile;
num_divisions=40; 

    % rearrange matrix
    tri1 = theta(:,1)';
    tri2 = theta(:,2)';
    almost = [tri1;tri2];
    concattri = almost(:);
    ang1 = theta(:,3)';
    ang2 = ang1(ones(1,2),:);
    ang2 = ang2(:);
    theta = [concattri, ang2];
    theta = sortrows(theta, -2);
        
    jump = floor(length(theta)*prob/num_divisions);
    
    %figure('units','normalized','outerposition',[0 0 1 1])
    
    pause(.3)
    trisurf(tri(theta(1:jump,1),:),pts(:,1),pts(:,2),pts(:,3));
    axis equal
    for time = 2:num_divisions
        pause(.3)
        j=time-1;
        index1 = jump*j+1;
        index2 = jump*time;
        trisurf(tri(theta(1:index2,1),:),pts(:,1),pts(:,2),pts(:,3));
        axis equal
        
    end



