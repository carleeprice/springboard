# This mini-project is based on the K-Means exercise from 'R in Action'
# Go here for the original blog post and solutions
# http://www.r-bloggers.com/k-means-clustering-from-r-in-action/

# Exercise 0: Install these packages if you don't have them already

# install.packages(c("cluster", "rattle","NbClust"))

# Now load the data and look at the first few rows
data(wine, package="rattle")
head(wine)

# Exercise 1: Remove the first column from the data 
# we will use this information later so store it in a list first, then remove
typelist <- wine$Type
wine$Type = NULL
# and scale it using the scale() function
scale(wine)

# Now we'd like to cluster the data using K-Means. 
# How do we decide how many clusters to use if you don't know that already?
# We'll try two methods.

# Method 1: A plot of the total within-groups sums of squares against the 
# number of clusters in a K-means solution can be helpful. A bend in the 
# graph can suggest the appropriate number of clusters. 

wssplot <- function(data, nc=15, seed=1234){
	              wss <- (nrow(data)-1)*sum(apply(data,2,var))
           	    for (i in 2:nc){
                  set.seed(seed)
                  wss[i] <- sum(kmeans(data, centers=i)$withinss)}
	                
		            plot(1:nc, wss, type="b", xlab="Number of Clusters",
	                        ylab="Within groups sum of squares")
	   }

wssplot(wine)

# Exercise 2:
#   * How many clusters does this method suggest?  
# 6 or 15

#   * Why does this method work? What's the intuition behind it?
# we know that a higher # of clusters will reduce the "space" between our clustered points
# taken too far, this means each point is its own cluster
# so rather than just minimizing for the sum of squares, lets see as we increase our number of 
# clusters, if there exists a point where the model becomes disproportionately better: 
# if there exists an inflection point on the plot
# here, that number would be 6 or 15

#   * Look at the code for wssplot() and figure out how it works
# it is a function that takes an input (data), 
# has a preset "nc" (number of iterations, in this case 15)
# and a set seed (for repeatability)
# it calcuates the number of rows in the data??
# for each of our 15 (nc) number of iterations/cluster counts, it calculates
# the "withinss" for each cluster, then sums them.  this becomes the y value for each point on our plot
# the x value is the number of clusers (the nc) used in that iteration

# Method 2: Use the NbClust library, which runs many experiments
# and gives a distribution of potential number of clusters.

library(NbClust)
set.seed(1234)
nc <- NbClust(wine, min.nc=2, max.nc=15, method="kmeans")
barplot(table(nc$Best.n[1,]),
	          xlab="Numer of Clusters", ylab="Number of Criteria",
		            main="Number of Clusters Chosen by 26 Criteria")


# Exercise 3: How many clusters does this method suggest?
# 2 or 11.  Since we're later creating a table that compares the types
# from the data set (there are three) to our clusters, we'll go with 2

# Exercise 4: Once you've picked the number of clusters, run k-means 
# using this number of clusters. Output the result of calling kmeans()
# into a variable fit.km

winefit <- kmeans(wine, centers = 2 )

# Now we want to evaluate how well this clustering does.

# Exercise 5: using the table() function, show how the clusters in fit.km$clusters
# compares to the actual wine types in wine$Type. Would you consider this a good
# clustering?

table(winefit$cluster, typelist)

# it's not bad.  OUr type 2 & 3 wines appear for the most part in cluster 1 and
# type 1 wines appear mostly in group 2

# Exercise 6:
# * Visualize these clusters using  function clusplot() from the cluster library
# * Would you consider this a good clustering?

library(cluster)
clusplot(pam(wine, 2))

# while this isn't as tidy as the data shown in the videos, and there is a good
# deal of overlap between the ellipses, it's a reasonable clustering.
