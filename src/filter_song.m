function filtered_song = filter_song(song_word_list, n)
%This function takes in a song as a cell array and filters out the n most
%popular words in the English language. n must be less than 5000

fileID = fopen('common_words.dat');
C = textscan(fileID,'%s');
common_words = C{1};
common_words = common_words(1:n);
for i = 1:length(common_words)
   common_word = common_words{i};
   bools = strcmp(common_word, song_word_list);
   indeces = find(bools);
   if(~isempty(indeces))
       song_word_list(indeces) = [];
   end
end

filtered_song = song_word_list;

end