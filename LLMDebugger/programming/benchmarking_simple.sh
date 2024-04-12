#!/bin/bash

# Activate the Conda environment
conda activate ldb

# Check if the activation was successful
if [ $? -eq 0 ]; then
    echo "Conda environment activated successfully."

    # Set the OpenAI API key environment variable
    export OPENAI_API_KEY='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'

    # Execute another shell script with an argument
    ./run_simple.sh humaneval gpt-4-32k-0613 gpt4_32k_0613/

else
    echo "Failed to activate Conda environment."
fi
