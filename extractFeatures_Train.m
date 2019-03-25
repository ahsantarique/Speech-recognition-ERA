clear; clc;


% Get a list of all files and folders in this folder.
files = dir('Training');
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);


X = []; % main data set for x;
y = []; %label of X;
label = 1;

% Print folder names to command window.
for k = 3: length(subFolders)	
	fprintf('\nSub folder #%d = %s\n', k, subFolders(k).name);
	% reading section
	filedir = dir(strcat('Training\',subFolders(k).name,'\*.wav'));
	           %list the current folder content for .wav file

	for ii = 1:length(filedir)        %loop through the file names
		fprintf(strcat(filedir(ii).name, '\n'));
	    %read the .wav file and store them in cell arrays
	    [v, f] = audioread(strcat('Training\',subFolders(k).name,'\',filedir(ii).name));


	    trec = size(v,1)/16000;
    	t = 0;
    	pos = 1;
    	data = zeros(16000,1);

	    for i = 800:size(v,1)
	    	t = t + 1;
	    	if(pos > size(v,1))
	    		break;
	    	end;
	    	if(16000-pos==size(v,1)-i)
	    		data(pos,1) = v(i,1);
	    		pos = pos + 1;
	    		continue;
	    	end;

	    	if(t >= trec)
	    		t = mod(t,trec);
	    		data(pos,1)= v(i,1);
	    		pos = pos+1;
	    	end;
	    end;

	    X = [X; data'];
	    y = [y; label];
	end;
	label = label + 1;
end;


%X = X./max(abs(X));
