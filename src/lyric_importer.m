
function [lyrics, all_words] = lyric_importer(genres)
%This function reads the lyric files for each genre and adds them to a cell
%array called lyrics. e.g. lyrics{0} = country words cell array. Also
%creates a master list of all_words. Input is a cell array of genres as
%strings. Function assumes the file for GENRE is located at
%'lyrics/lyrics_GENRE.dat'.

    
    lyrics = {}; 

    total_num_words = 0;

    for i = 1:length(genres)
        %Read each .dat file
        genre = genres{i};
        file_location = strcat('lyrics/lyrics_',genre,'.dat');
        fileID = fopen(file_location);
        C = textscan(fileID,'%s'); %create a cell array of strings from the file
        lyrics{i} = C{1};
        total_num_words = total_num_words + length(lyrics{i});
        fclose(fileID);
    end

    all_words = cell(1,total_num_words); %create empty cell array 

    all_words_index = 0;

    for i = 1:length(genres)    %loop through the genres
        for j = 1:length(lyrics{i})    %loop through the words in that genre
            word = lyrics{i}{j};  %get word
            word = upper(word);   %convert word entirely to uppercase     
            lyrics{i}{j} = word; %replace the word in the list with upper version

            all_words_index = all_words_index + 1;

            all_words{all_words_index} = word; %add word to the all_words list

           % fprintf('Importing Lyrics... Words completed: %d / %d\n', all_words_index, total_num_words); %print status
        end
    end
end
