model=$1

run_names=("run1")
for run_name in "${run_names[@]}"; do
  python main.py \
    --run_name $run_name \
    --root_dir ../output_data/lats/humaneval/$model/ \
    --dataset_path ./benchmarks/humaneval-py.jsonl \
    --strategy "mcts" \
    --language "py" \
    --model $model \
    --pass_at_k "1" \
    --max_iters "8" \
    --max_num_int_tests "6" \ # set this to 4 for gpt-4 and 6 for gpt-3.5 runs
    --verbose
done
