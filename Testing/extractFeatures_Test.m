
% reading section
filedir = dir('*.wav');
           %list the current folder content for .wav file
X = [];

for ii = 1:length(filedir)        %loop through the file names
    fprintf(strcat(filedir(ii).name, '\n'));
    %read the .wav file and store them in cell arrays
    [v, f] = audioread(filedir(ii).name);


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

        maxv = -inf;
        if(t >= trec)
            t = mod(t,trec);
            data(pos,1)= max(maxv,v(i,1));
            pos = pos+1;
        else
            maxv = max(maxv,v(i,1));
        end;
    end;

    X = [X; data'];
end;
X = X./max(abs(X));


predict(Theta1, Theta2, X);
