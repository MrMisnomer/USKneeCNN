classdef Mini < matlab.io.Datastore & ...
                       matlab.io.datastore.MiniBatchable
    
    properties
        MiniBatchSize
        patchSize
        batchImages
        imsize
    end

    properties(SetAccess = protected)
        NumObservations
    end

    properties(Access = private)
        % This property is inherited from Datastore
        CurrentFileIndex
        % These custom properties store copies of the two ImageDatastores
        InputImds
        LabelImds
        EnhancedImds
        RWImds
    end


    methods
        
        function ds = Mini(inputImds,EnhancedImds,RWImds,LabelImds,patchSize,miniBatchSize,batchImages,imsize)
            % Construct an associatedImageDatastore object
            ds.InputImds = copy(inputImds);
            ds.EnhancedImds = copy(EnhancedImds);
            ds.LabelImds = copy(LabelImds);
            ds.RWImds = copy(RWImds);
%             ds.InputImds.ReadSize = miniBatchSize;
%             ds.OutputImds.ReadSize = miniBatchSize;
            ds.patchSize = patchSize;
            ds.batchImages = batchImages;
            ds.NumObservations = length(inputImds.Files);
            ds.MiniBatchSize = miniBatchSize;
            ds.CurrentFileIndex = 1;
            ds.imsize = imsize;
        end

        function tf = hasdata(ds)
            % Return true if more data is available
            tf = (hasdata(ds.EnhancedImds)& hasdata(ds.InputImds));
        end

        function [data,info] = read(ds)            
            % Read one batch of data
%             inputImageData = read(ds.InputImds);
%             outputImageData = read(ds.LabelImds);
%             data = table(inputImageData,outputImageData);
                info.batchSize = ds.MiniBatchSize;
%             ds.CurrentFileIndex = ds.CurrentFileIndex + info.batchSize;
                info.currentFileIndex = ds.CurrentFileIndex;  

                [max_images,~] = size(ds.InputImds.Files);
                num_images = ds.MiniBatchSize;
%                 patch_size = ds.patchSize;
                imgsize = ds.imsize(1);
                data = table({1},{1});
                data.Properties.VariableNames = {'image','labels'};
                data = repmat(data,num_images,1);
                A = zeros(imgsize,imgsize,1);
                for i = 1:num_images
                    r = randi(max_images);
                    vars = round(rand([1,4]));
                    
                    Images{1} = readimage(ds.InputImds,r);
%                     if r <=50
%                        Images{1} = ClariusReader(ds.InputImds.Files{r});
%                     else
%                        Images{1} = readimage(ds.InputImds,r);
%                     end
%                     Images{2} = readimage(ds.EnhancedImds,r);
%                     Images{2} = Enhance_Image(readimage(ds.InputImds,r));
%                     Images{1} = readimage(ds.RWImds,r);
                    Images{2} = readimage(ds.LabelImds,r);
                    outputImages = augimg1(Images,vars,ds.imsize);

                    A(:,:,1) = outputImages{1};
%                     A(:,:,2) = Enhance_Image(outputImages{1});
%                     A(:,:,3) = outputImages{3};
                    
                    
%                     outlbl = imageLabels(1:imgsize,1:imgsize);

                    data{i,1} = {A};
                    data{i,2} = outputImages(end);
                end
                
                
                
        end

        function reset(ds)
            % Reset to the start of the data
            reset(ds.InputImds);
            reset(ds.LabelImds);
            reset(ds.EnhancedImds);
            reset(ds.RWImds);
            ds.CurrentFileIndex = 1;
        end
        
    end 

    methods (Hidden = true)

        function frac = progress(ds)
            % Determine percentage of data read from datastore
            frac = (ds.CurrentFileIndex-1)/ds.NumObservations;
        end

    end

end % end class definition
