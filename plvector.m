% this file is going to calculate the persistent homology of each 3D figure
% filtered by the angle of neighboring triangles. This file takes time. Be
% sure to call: load_javaplex and configure the directories.
% Parameters: 
%       percentile: percentile of triangles added by angle between the two
%       num_divisions: number of divisions over 'time' interval
%       k: the max number of overlapping barcode intervals to consider
%           this is a parameter of the landscape vector

dir1=strcat(pwd,'/nonrigid3d/*.tri');
dir2=strcat(pwd,'/nonrigid3d/*.txt');
files1 = dir(dir1);
files2 = dir(dir2);

% Parameters:
    % lets consider 70th percentile of triangles by angle
    percentile = .7 ;
    prob = 1- percentile; 
    % number division=order of partition of sorted angle matrix (theta)
    num_divisions=40; 
    % k: max number of overlapping intervals.
    % interpretted as max number of local concavity regions considered.
    k=15;
tic
for c= 1:length(files2)%length(files1)
    clearvars theta
    stream = api.Plex4.createExplicitSimplexStream();
    
    tri=load(files1(c).name);
    theta=load(files2(c).name);
    
    % reorder theta: to n x 2 matrix:( tri, angle) then sort: desending angle
    
    tri1 = theta(:,1)';
    tri2 = theta(:,2)';
    almost = [tri1;tri2];
    concattri = almost(:);
    ang1 = theta(:,3)';
    ang2 = ang1(ones(1,2),:);
    ang2 = ang2(:);
    theta = [concattri, ang2];
    theta = sortrows(theta, -2);
    
    % Design decision: partition by index or angle?
    %   I think we should partition by index of matrix
    %   because it in a sense standardizes the angle
    %   relative to each image.
    
    % Add each element at each time interval (partition's index) 
    jump = floor(length(theta)*prob/num_divisions);
    for i = 1:jump
        stream.addElement(tri(theta(i),:),1);
    end
    stream.ensureAllFaces();
    for time = 2:num_divisions
        j=time-1;
        index1 = jump*j+1;
        index2 = jump*time;
        for p = index1:index2
            stream.addElement(tri(theta(p),:),time);
        end
        stream.ensureAllFaces();
        
    end
    
    %prepares stream for persistence algorithms
    stream.finalizeStream();
    num_simplices=stream.getSize()
    
    persistence = api.Plex4.getModularSimplicialAlgorithm(3,2);
    intervals=persistence.computeIntervals(stream);
    
    % Computes interval matrix and persistence landscape vector. store
    % as "filename_lv.txt"   vector: k1t1,k2,t1,...,k1t2,k2t2,....
    interval_matrix=edu.stanford.math.plex4.homology.barcodes.BarcodeUtility.getEndpoints(intervals,1,0);    
    lndscp = persistenceLandscapeMatrix(interval_matrix,1,num_divisions,k,num_divisions);
    lndscpv = lndscp(:);
    
    %save into dir with all image files
    l=files1(c).name;
    filename=strrep(l,'.tri','.plv');
    dir3=strcat(pwd,'/nonrigid3d/');
    filename = strcat(dir3,filename);
    dlmwrite(filename,lndscpv, 'delimiter',' ');
    
    
    %options.max_filtration_value = max_filtration;
    %plot_barcodes(intervals,options);
    
end 
toc
