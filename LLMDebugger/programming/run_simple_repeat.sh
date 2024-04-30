dataset=$1
model=$2
fallback_name=$3
strategy="simple_repeat"
run_names=("run1")
for run_name in "${run_names[@]}"; do
  python main.py \
    --run_name $run_name/ \
    --root_dir ../output_data/$strategy/$dataset/$fallback_name/ \
    --dataset_path ../input_data/$dataset/dataset/probs.jsonl \
    --strategy $strategy \
    --model $model \
    --n_proc "1" \
    --testfile ../input_data/$dataset/test/tests.jsonl \
    --verbose \
    --port "8000"

done