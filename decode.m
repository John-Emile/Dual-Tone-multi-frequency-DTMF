function x = decode(F1,F2)

%% INITIALIZE VARIABLES
keypad = {'1' '2' '3' 'A' ; '4' '5' '6' 'B' ;'7' '8' '9' 'C';'*' '0' '#' 'D'}; 
lowfreq = [697 770 852 941]; % Low frequency group
highfreq = [1209 1336 1477 1633]; % High frequency group
keypad_button_index = [];
fLow = 0;
fMax = 0;

if F1>F2
    fLow = F2;
    fMax = F1;
else
    fLow = F1;
    fMax = F2;
end    

for r=1:4 %4 columns
		for c=1:4 %4 rows
          
            %filling the array with 3rows*16col with low freq,high freq and
            %index respectively
			keypad_button_index = [ keypad_button_index [lowfreq(r);highfreq(c);keypad(r,c)]];
        end
end

for c=1:16 %16 columns
    compL = keypad_button_index{1,c};
    compH = keypad_button_index{2,c};

    if fLow == compL && fMax == compH
        x = keypad_button_index{3,c}; 
    end
end


