#!/bin/bash
subjectID=386

conda init
# Activate the PriorMDM environment
conda activate PriorMDM
# Change directory to priorMDM
cd priorMDM
# Run the double_take module
python -m sample.double_take --model_path ./save/my_humanml_trans_enc_512/model000200000.pt --handshake_size 20 --blend_len 10 --input_text ./assets/dt_csv_example.csv 
# Run the render_mesh module
python -m visualize.render_mesh --input_path /home/rishabhswapnil/priorMDM/save/my_humanml_trans_enc_512/DoubleTake_samples_my_humanml_trans_enc_512_000200000_seed10_dt_csv_example_handshake_20_double_take_blend_10_skipSteps_100/sample00_rep00.mp4
# Deactivate the environment
conda deactivate
# Return to the previous directory
cd ..

# Execute a notebook
jupyter nbconvert --to notebook --execute final_parameter_conversion.ipynb --output final_parameter_conversion.ipynb

# Activate the arah environment
conda activate arah
# Change directory to arah-release
cd arah-release/
# Set the PYTHONPATH environment variable
export PYTHONPATH=${PWD}
# Run the preprocess_aist.py script
python preprocess_datasets/preprocess_aist.py --data-dir ./aist_motion/motions --seqname data_test --subject CoreView_$subjectID
# Deactivate the environment
conda deactivate
# Return to the previous directory
cd ..

# Copy files
cp -r /home/rishabhswapnil/arah-release/data/odp/CoreView_$subjectID/data_test_view1 /home/rishabhswapnil/3dgs-avatar-release/data/ZJUMoCap/CoreView_$subjectID/

# Activate the 3dgs-avatar environment
conda activate 3dgs-avatar
# Change directory to 3dgs-avatar-release
cd 3dgs-avatar-release/
# Run the render script
python render.py mode=predict dataset.predict_seq=4 dataset=zjumocap_${subjectID}_mono
# Deactivate the environment
conda deactivate
# Navigate to the directory containing the render output
cd exp/zju_${subjectID}_mono-direct-mlp_field-ingp-shallow_mlp-default/predict-user_input/renders
# Run ffmpeg to convert images to video
ffmpeg -framerate 10 -i render_c01_f%06d.png -c:v libx264 -pix_fmt yuv420p -r 10 baseline_386_output.mp4
cp -r baseline_386_output.mp4 /home/rishabhswapnil/Final-Output
cd ..
cd ..
cd ..
cd ..
cd ..
 