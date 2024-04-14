dataset=$1
model=$2
seedfile=$3
strategy="ldb"
run_names=("run1" "run2" "run3" "run4" "run5")
for run_name in "${run_names[@]}"; do
  python main.py \
    --run_name $run_name/ \
    --root_dir ../output_data/$strategy/$dataset/$model/ \
    --dataset_path ../input_data/$dataset/dataset/probs.jsonl \
    --strategy $strategy \
    --model $model \
    --seedfile ../output_data/simple/$dataset/$model/$run_name/$seedfile \
    --pass_at_k "1" \
    --max_iters "10" \
    --n_proc "1" \
    --port "8000" \
    --testfile ../input_data/$dataset/test/tests.jsonl \
    --verbose
done