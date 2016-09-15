function song_word_list = read_song_from_dat(filename)
%This function takes in a filename of a song's lyrics and then returns that 
%song as a cell array of strings. FILENAME is assumed to be in location
%'unknown_songs/FILENAME.dat'

    file_location = strcat('unknown_songs/',filename,'.dat');
    fileID = fopen(file_location);
    C = textscan(fileID,'%s');
    song_lyrics = C{1};
    fclose(fileID);

    for i = 1:length(song_lyrics)    %loop through the words in the song lyrics
       word = song_lyrics{i};  %get word
       word = upper(word);   %convert word entirely to uppercase
       
       %Go through each character in the word and remove all non-letters
       k = 1;
       while (k <= length(word))
            x = word(k); 
            if ~(x>='A' && x<='Z')  %if x is not a letter from A to Z
                word = strcat(word(1:k-1), word(k+1:end));  %cut the letter out of the word
            else
                k = k+1;
            end
       end
            
       song_lyrics{i} = word; %replace the word in the list with the filtered word
       
    end
    
    song_word_list = song_lyrics;

end