function [predicted_labels,idx,accuracy] = KNN2(k,data,labels,t_data,t_labels)
global g;
disp("knn");
%KNN_: classifying using k-nearest neighbors algorithm. The nearest neighbors
%search method is euclidean distance
%Usage:
%       [predicted_labels,nn_index,accuracy] = KNN_(3,training,training_labels,testing,testing_labels)
%       predicted_labels = KNN_(3,training,training_labels,testing)
%Input:
%       - k: number of nearest neighbors
%       - data: (NxD) training data; N is the number of samples and D is the
%       dimensionality of each data point
%       - labels: training labels 
%       - t_data: (MxD) testing data; M is the number of data points and D
%       is the dimensionality of each data point
%       - t_labels: testing labels (default = [])
%Output:
%       - predicted_labels: the predicted labels based on the k-NN
%       algorithm
%       - nn_index: the index of the nearest training data point for each training sample (Mx1).
%       - accuracy: if the testing labels are supported, the accuracy of
%       the classification is returned, otherwise it will be zero.
%Author: Mahmoud Afifi - York University 

%checks
if nargin < 4
    error('Too few input arguments.')
elseif nargin < 5
    t_labels=[];
    accuracy=0;
end

if size(data,2)~=size(t_data,2)
    error('data should have the same dimensionality');
end

if mod(k,2)==0
    error('to reduce the chance of ties, please choose odd k');
end

%calc euclidean distances between each testing data point and the training
%data samples
[ed,idx] = pdist2(data,t_data,'euclidean','Smallest',k);
disp(ed);
%find the nearest k for each data point of the testing data

predicted_labels(0)=labels(idx);

disp(predicted_labels(0));
%calculate the classification accuracy
