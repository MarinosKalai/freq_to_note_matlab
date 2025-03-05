%--------------------------------------------------------------------------
% File Name:    freq_to_note_matlab.m
% Author:       Marinos Kalaitzakis
% Date:         05-03-2025
%
% Description:
% This function converts a frequency (Hz) to a musical note.
%
% Inputs:
% Frequency (Hz)
% Outputs:
% Note and cents

function freq_to_note_matlab(in_Hz)

arguments
    in_Hz {mustBeNumeric}
end

cents_of_note = [0,100,200,300,400,500,600,700,800,900,1000,1100];
notes = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"];


step = 2^(1/1200);

A0 = 27.5;
C0 = A0/(2^(9/12));


dl = C0/in_Hz;

step_in = abs(log10(dl)/log10(step));

octave = step_in/1200;

aux_var = fix(octave) - octave;
aux_var = abs(aux_var);

% octave finder
if aux_var >= 0.95
    octave = ceil(octave); %octave
%     fprintf('\n\n Error 1 \n\n')
elseif aux_var >= 0.9
    octave = fix(octave); %octave
%     fprintf('\n\n Error 2 \n\n')
else
    octave = fix(octave);
end

% note finder


cents = step_in-(octave*1200);
cents_for_search = round(cents,-2);

if cents_for_search <= 1100

    if cents_for_search ~= round(cents)
        cents_print = ((round(cents))-cents_for_search);
%         fprintf('\n\n Error 3 \n\n');
        aux_var = find(abs(cents_for_search)==cents_of_note);
        note_print = notes(aux_var);
        if (cents_print) > 0
            fprintf('\n\n %s%d (+%d cents) \n\n',note_print,octave,cents_print);
        else
            fprintf('\n\n %s%d (%d cents) \n\n',note_print,octave,cents_print);
        end
    else
        aux_var = find(cents_for_search==cents_of_note);
        note_print = notes(aux_var);
        fprintf('\n\n %s%d \n\n',note_print,octave);
    end

else
%     fprintf('\n\n Error 4 \n\n')
end

end
