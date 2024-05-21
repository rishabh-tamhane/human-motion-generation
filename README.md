# human-motion-generation

# 3DGS Avatar - Prior MDM Baseline Model 

Setup the environment for 3DGS-Avatar and Prior MDM.
The output of the Prior MDM were SMPL Parameters in the 6D space. While, the expected input of the
3DGS-Avatar was in the 3D space. The first step setting up the converter and comparing the baseline results.

Code : source run_baseline.sh

# 3DGS Avatar - Prior MDM Finetuned Model
The current model does not perform well on out-of-distribution poses. Due to the lack of ground truth data,
we checkpoint the model during the initial training phase. We then use the predicted outputs as pseudoground
truth, in conjunction with the initial training data, to continue training the model.

Code : source run_finetune1.sh

# 3DGS Avatar - Prior MDM Test Time Training Finetuning

Since we do not have access to the ground truth for test data and the pseudo-ground truth may not
be reliable for training, it is crucial to enhance the model’s ability to generalize to out-of-distribution
data. By leveraging TTT, we aim to improve the model’s performance in scenarios where the test
data differs significantly from the training data.

Code : source run_finetune2.sh
