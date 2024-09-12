% MATLAB model of the DSP_Filter 
clear;
% Filter Coefficients
% I will use shift in the filter o save the resorces
% So this values will be inversed
H1 = 1;
H2 = 0.5;
H3 = 0.25;
H4 = 0.125;

% Open files to write input and output
% As i wanna use it in the testbench
input_file = fopen('input1.txt', 'w');
output_file = fopen('output1.txt', 'w');

% Number of clock cycles to simulate
% As thier is no clock here in matlab so i will simulate one 
num_cycles = 100;

% Initialize input, output, and delay registers
N = 7; % Bit-width of input/output, it may change to increase the performance
x = zeros(1, num_cycles);     % Input signal
y = zeros(1, num_cycles);     % Output signal
delayed_x = zeros(3, 1);      % Delay registers

% Generate random input values for testing We can replace with your own
% But I wanna make it more efficient, so i'll use random input values
% Here, we'll generate random 8-bit unsigned values :)
x = randi([0, 2^N-1], 1, num_cycles);

% Loop through each cycle (simulating each clock edge) as we have no clk on
% the model
% note
% We may generate the model using simulink and use high level synsises to
% Generate the RTL and the Testbench

for i = 1:num_cycles
    % Shift delayed values
    delayed_x(4) = delayed_x(3);
    delayed_x(3) = delayed_x(2);
    delayed_x(2) = delayed_x(1);
    delayed_x(1) = x(i);
    % Compute the output
    y(i) = floor(H1 * delayed_x(1)) + floor(H2 * delayed_x(2)) + floor(H3 * delayed_x(3)) + floor(H4 * delayed_x(4));
    
    % Write input and output to files
    fprintf(input_file, '%X\n', x(i));      % Write input as hexadecimal
    fprintf(output_file, '%X\n', round(y(i)));  % Write output as hexadecimal, rounded to nearest integer
    
    % Optional: Display results in MATLAB console
    fprintf('Cycle %d: Input = %d, Output = %.2f\n', i, x(i), y(i));
end

% Close the files
fclose(input_file);
fclose(output_file);

% Plot the input and output signals
figure;
subplot(2, 1, 1);
stem(x, 'filled');
title('Input Signal (x)');
xlabel('Time (cycles)');
ylabel('Amplitude');

subplot(2, 1, 2);
stem(y, 'filled');
title('Filtered Output Signal (y)');
xlabel('Time (cycles)');
ylabel('Amplitude');
