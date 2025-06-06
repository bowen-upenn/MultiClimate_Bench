#!/bin/bash

# Get rank from MPI environment
RANK=$PMI_RANK
SIZE=$PMI_SIZE

# Define all tasks
declare -a TASKS=(
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 0 100"
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 100 200"
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 200 300"
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 300 400"
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 400 500"
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 500 600"
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 600 700"
  "bash ./scripts/run_inference_qwen_2p5_vl_7b.sh code 700 800"
)

# Calculate which tasks this rank should handle
for i in "${!TASKS[@]}"; do
  if [ $((i % SIZE)) -eq $RANK ]; then
    echo "RANK $RANK executing task $i: ${TASKS[$i]}"
    eval "${TASKS[$i]}"
    echo "RANK $RANK completed task $i"
  fi
done
