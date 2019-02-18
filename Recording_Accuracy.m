try
    %% Collecting 2AFC response
    Screen('Preference','SkipSyncTests',1);
    rng('shuffle'); %reseeds random number generator
    [window,rect]=Screen('OpenWindow',0); %window: name of window, %rect, coords of window
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %makes transparent
    HideCursor(); 
    window_w = rect(3);
    window_h = rect(4);
    center_x = window_w/2; %x center of screen
    center_y = window_h/2; %y center of screen

    KbName('UnifyKeyNames');
    % While most keynames are shared between Windows and Macintosh, not all
    % are. Some key names are used only on Windows, and other key names are
    % used only on Macintosh. KbName will try to use a mostly shared name
    % mapping if you add this command
    order_trial=['s' 's' 'k' 'k'];
    order_trial=Shuffle(order_trial);

    for i=1:4
        while  1

            % Check which key was pressed
            [keyIsDown,seconds,keyCode] = KbCheck(-1);
            % -1 represent the default device


            % ikf 's' or 'k' key was pressed, jump out of the while loop. 
            % 'break' can also be used in a for loop
            
            if keyCode(KbName('s'))
                response(i) = 's';
                break   
            end

            if keyCode(KbName('k'))
                response(i) = 'k';
                break
            end

        end
        
        while keyIsDown == 1
            [keyIsDown,seconds,keyCode] = KbCheck(-1);
        end
    end


    %% Determining Accuracy of Response

    % order_trial determined the positioning of the stimuli
    % when order_trial is 1, correct response should be 's'
    % when order_trial is 2, correct response should be 'k'
    % If subject gives a correct response, give the variable "accuracy" a
    % value of 1. If incorrect, give it a value of 0
    accuracy = [];
    percentage=0;
    for t = 1:4
        if strcmp(response(t),order_trial(t)) == 1
            accuracy(t)=1;
            percentage=percentage + 1;
        else
            accuracy(t)=0;
        end
    end
    percentage=percentage/4*100;
    Screen('CloseAll');

    % Tips: if-statement, function 'strcmp' and logic operator "&&"
catch
    Screen( 'CloseAll');
    rethrow(lasterror)
end;
