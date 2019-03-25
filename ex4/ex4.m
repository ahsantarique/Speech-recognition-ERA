%%==================== Initialization ==========================
%% Setup the parameters you will use for this exercise
input_layer_size  = 16000;  
hidden_layer_size = 100;   
num_labels = label-1;             


m = size(X, 1);

%% ================ Initializing Pameters ================

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%% =================== Training NN ===================
fprintf('\nTraining Neural Network... \n')
options = optimset('MaxIter', 50);
lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Training done. Press enter to continue.\n');
pause;

%% ================= Predict on Training Data =================
pred = predict(Theta1, Theta2, X);

fprintf('\nTraining Set Accuracy: %f %% \n', mean(double(pred == y)) * 100);
