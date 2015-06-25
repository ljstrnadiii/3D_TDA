# 3D_TDA
### requirements
The project requires Javaplex which can be found [here](http://appliedtopology.github.io/javaplex/). It also requires the 3D image data which can be found [here](http://tosca.cs.technion.ac.il/book/resources_data.html). 
<br>
<br>
### summary
There are 300 or so 3D images as point clouds or triangulations. The idea for this project was to create an explicit filtered simplicial complex from the point cloud filtered by the angle between neighboring triangles in the triangulation. Essentially, we introduced the triangles which had a larger angle between neighboring triangles. The idea was to introduce parts of the image with tighter concavity. We calculate the persistent homology of this filtered simplicial complex and find each images corresponding persistent landscape vector [more here](http://arxiv.org/abs/1207.6437). Using the principal components of the persistent landscape vector we are able to see come clustering in the biplot.
<br>
<br>
refer to the pdf for the analysis.
## Sequence:
* **`go.m`** - computes the angle between all triangles and stores in a matrix (row,col) = (tri1,tri2)
* **`plvector.m`** - this file calculate the persistent homology of each figure and finds the corresponding persistent landscape vector and stores it to the directory with image files. Read the header of the file to learn about parameters. 
* **`pcplot.m`** - This function takes a list which indexes the image type i.e. dog, cat. There are multiple images of dogs and cats etc. The result is a plot of the principal components of those image types. 
* **other_files** - other files are utility and required by the three above. 
