clc;
clear all;
close all;
% this demo will get MNIST data automatically and start a training on network specified in 'mnist.conf'
% it will reach 94% in several minutes, 99.2% in couple of hours

addpath('../../Training' , '../../mdCNN' , '../../utilCode' );

net = CreateNet('../../Configs/mnist.conf'); 

% dataset_folder = 'MNIST_dataset';
% 
% MNIST = getMNISTdata(dataset_folder);    

tr_f='Img/train';
a=dir(tr_f);
ind=size(a,1);
aa=1;
labels=[];
for kk=3:ind
    
    temp=a(kk).name;
    I{aa}=uint8(imresize(rgb2gray(imread(strcat(tr_f,'/',temp))),[28 28]));
    aa=aa+1;
    if findstr(temp,'a')
        
        
    labels=[labels; 1];
    
    end
    
    if findstr(temp,'b')
        
        
    labels=[labels; 2];
    
    end
    
    if findstr(temp,'c')
        
        
    labels=[labels; 3];
    
    end
    
    if findstr(temp,'d')
        
        
    labels=[labels; 4];
    
    end
    
    if findstr(temp,'e')
        
        
    labels=[labels; 5];
    
    end
end
labels=labels-1;
aa=1;
ts_f='Img/test';
a=dir(ts_f);
ind=size(a,1);
aa=1;
labels_test=[];
for kk=3:ind
    
    temp=a(kk).name;
    I_test{aa}=uint8(imresize(rgb2gray(imread(strcat(ts_f,'/',temp))),[28 28]));
    aa=aa+1;
    if findstr(temp,'a')
        
        
    labels_test=[labels_test; 1];
    
    end
    
    if findstr(temp,'b')
        
        
    labels_test=[labels_test; 2];
    
    end
    if findstr(temp,'c')
        
        
    labels_test=[labels_test; 3];
    
    end
    
    if findstr(temp,'d')
        
        
    labels_test=[labels_test; 4];
    
    end
    if findstr(temp,'e')
        
        
    labels_test=[labels_test; 5];
    
    end
end

labels=uint8(labels);

labels_test=uint8(labels_test);
labels_test=labels_test-1;

save('MNIST.mat','I','labels','I_test','labels_test');
MNIST=load('MNIST.mat');
% start training, will train for 15k images. Reach about 96.30% in several minutes. 
% In order to reach 99.2% remove the last parameter (15k) and let it train longer.
% It will stop training automatically (once ni reach below thresh)
net   =  Train(MNIST,net, 16);


checkNetwork(net,Inf,MNIST,1);
mm=load('mm.mat');
mm=mm.mm;
disp('Detected Output is : ')
disp(mm);
disp('Actual Input Test Data is :')
labels'

%displayMNIST will open a small GUI where you can check the network on MNIST dataset
% displayMNIST(net, 'MNIST_dataset'); 

%displayFilters will show the network filters on some input image
% displayFilters(net , MNIST.I{1} , num2str(MNIST.labels(1)));

% Notes:
% Train will save the network to a file after each iteration. (net.mat) 
% you can call 'Train' again on an existing net, it will continue training where it stopped.

