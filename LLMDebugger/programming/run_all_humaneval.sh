model_names=("gpt-3.5-turbo-1106" "gpt-4-1106-preview" "gpt-4-turbo-2024-04-09")
for model_name in "${model_names[@]}"; do
    ./run_simple.sh humaneval $model_name
done

model_names=("gpt-3.5-turbo-0125" "gpt-3.5-turbo-1106" "gpt-4-1106-preview" "gpt-4-turbo-2024-04-09")
for model_name in "${model_names[@]}"; do
    seed_file="probs._simple_10_${model_name}_pass_at_1_seed_.jsonl"
    ./run_ldb.sh humaneval $model_name $seed_file
done
