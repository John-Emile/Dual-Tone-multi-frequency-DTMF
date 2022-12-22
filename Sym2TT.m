function x = Sym2TT(S)

%% INITIALIZE VARIABLES
Fs = 8000;
t = 0:1/Fs:0.1;

keypad = {'1' '2' '3' 'A' ; '4' '5' '6' 'B' ;'7' '8' '9' 'C';'*' '0' '#' 'D'}; 
lowfreq = [697 770 852 941]; % Low frequency group
highfreq = [1209 1336 1477 1633]; % High frequency group

%Creating an array that have the low freq & high freq & index of all
%possible buttons
keypad_button_index = [];

%counter of index
index_low=0;
index_high=0;

%% Make frequency array
	for r=1:4 %4 columns
		for c=1:4 %4 rows
          
            %filling the array with 3rows*16col with low freq,high freq and
            %index respectively
			keypad_button_index = [ keypad_button_index [lowfreq(r);highfreq(c)] ]; 
			           
            %assign the keypad current value to variable comp to compare it
            %with the given element, use curley brackets to get the element
            comp = keypad{r,c};
            
            %cast the variable coming from keypad (from char to double) and
            %compare it with input coming from user
            %if input == str2double(comp)
            if S == comp

                %Get the index 
                index_low = r;
                index_high = c;
            else
                % do nothing
            end
		end
    end
    
f_low = lowfreq(index_low);
f_high = highfreq(index_high);
x = cos(2*pi*f_low*t) + cos(2*pi*f_high*t);
x = x+0;
end
