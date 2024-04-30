# Repository to blogpost: AI leaderboards are no longer useful. It's time to switch to Pareto curves.

This repository contains the accompanying code to the blog post with the title [AI leaderboards are no longer useful. It's time to switch to Pareto curves.](https://www.aisnakeoil.com/) by Sayash Kapoor, Benedikt Stroebl, and Arvind Narayanan. 

Part of the analysis for this blog post builds on the following three publications and their accompanying code repositories, which we used for reproducing their work.

**Reflexion ---**
[Reflexion: Language Agents with Verbal Reinforcement Learning](https://arxiv.org/abs/2303.11366) ([GitHub](https://github.com/noahshinn/reflexion/blob/main/programming_runs/simple.py))

**LDB ---**
[LDB: A Large Language Model Debugger via Verifying Runtime Execution Step by Step](https://arxiv.org/abs/2402.16906) ([GitHub](https://github.com/floridsleeves/llmdebugger))

**LATS ---**
[Language Agent Tree Search Unifies Reasoning Acting and Planing in Language Models](https://arxiv.org/abs/2310.04406) ([GitHub](https://github.com/andyz245/LanguageAgentTreeSearch))

[Language Agent Tree Search Unifies Reasoning Acting and Planing in Language Models](https://arxiv.org/abs/2310.04406) ([GitHub](https://github.com/andyz245/LanguageAgentTreeSearch))

### General notes

#### Structure

- This repository is organized so that each high-level agent has its own dedicated directory, mirroring the structure of the original repositories associated with the respective research papers.
- Additionally, our baseline agents are built upon the LDB codebase and are therefore housed within the LLMDebugger directory.
- Each of the three primary directories includes an `output_data/` folder, which contains the result logs from the experiments we conducted.
- The bash script referenced below for running each model/agent reported in the blog post can be found in the `programming` folder within the main directories.
    
#### Logging

- To track inference times and costs associated with the agents, we added code at relevant points within the source code. The resulting log files are stored alongside the results from solving the HumanEval tasks in the `output_data/` subdirectories located within each agent directory.
- **Note on interrupted runs:** Some experimental runs were interrupted mid way through the HumanEval problems (e.g., due to budget limits or network errors). We restarted these runs from the point of interruption (i.e., starting at the earliest unsolved HumanEval problem) to conserve costs. This means that the accuracy reflected in the LATS `.jsonl` files is not accurate in these instances ([example](https://github.com/benediktstroebl/agent-eval/blob/2a5afc1a29e539b28a870b7431d9b9a3bc4f21ef/LanguageAgentTreeSearch/output_data/lats/humaneval/gpt-4-turbo-2024-04-09/run1/humaneval-py._mcts_8_gpt-4-turbo-2024-04-09_pass_at_k_1_py.jsonl)). You can refer to the respective `.log` files stored in the same folder for the correct accuracy numbers. (To be clear, this only affects the log files stored by LATS. It does not affect the actual accuracy of the agent, nor the results reported in the blog post.)

#### Changes made to source code of agent papers

In order to reproduce the work of the publications mentioned above and to address encountered reproducibility issues, we had to make changes to the original code as provided by the authors. All of these changes are part of the commit history of this repository and can be inspected transparently. For more details on some of the reproducibility issues, please refer to the accompanying blog post.

#### Additional questions and details

You can refer to the blog post and its associated appendices for more details on our setup. You can contact us at [sayashk, stroebl, arvindn]@princeton.edu

## Running agents and models

To set up the environments to run each agent, follow these steps:

1. Clone this repo and move to the respective agent directory:
```bash
git clone https://github.com/benediktstroebl/agent-eval.git
```

2. For each agent repository, create an environment with the provided module dependencies contained in the respective folder:
```bash
pip install -r requirements.txt
```

3. Set `OPENAI_API_KEY` environment variable to your OpenAI API key:
```bash
export OPENAI_API_KEY=<your key>
```

### To run LDB agents, simple models, and baselines

#### To run simple models and baselines

- `Simple models` -  This uses the simple strategy implemented in the code accompanying the LDB agent for zero-shot evaluations of language models (i.e., there is no agent architecture).

    ```bash
    cd ./programming
    ./run_simple.sh humaneval [model] [output_dir]
    ```

 - `Escalation` - We modify the simple strategy of LDB but switch the underlying model to a more expensive one if a proposed solution fails at least one of the example tests. Running the script below will start five runs with `llama-3-8b-chat-hf`, `gpt-3.5-turbo-0125`, ​​`llama-3-70b-chat-hf`, `gpt-4-turbo-2024-04-09` as backend fallback models.

    ```bash
    cd ./programming
    ./run_simple_boosting.sh humaneval [name_you_can_set]
    ```

 - `Retry` - Simple strategy that repeatedly prompts the same language model, keeping all parameters equal across retrials, as long as the code outputted by the model failed at least one of the example tests.

    ```bash
    cd ./programming
    ./run_simple_repeat.sh humaneval [model] [name_you_can_set]
    ```

 - `Warming` - For the Warming baseline, we modify the Retry baseline by gradually increasing the temperature parameter across successive trials.

    ```bash
    cd ./programming
    ./run_simple_incr_temp.sh humaneval [model] [name_you_can_set]
    ```

### To run LDB agents

 -  - LDB agents require a seed file containing already-existing solutions from a model or agent, which the LDB agent then debugs. To start an LDB agent from scratch, first create the seed files using the steps listed in the simple agents and models part above.
 - `LDB with seed from simple strategy` - Use this if you want to reproduce LDB agents that use a seed generated using the simple models or agents. The resulting folder containing the outputs and logs will follow the nomenclature **model**+**seedmodel**.

    ```bash
    cd ./programming
    ./run_ldb.sh humaneval [model] [seedmodel]
    ```
    **Note:** This assumes that the respective seed is already in the output_data directory at the appropriate location.

 - `LDB with Reflexion seed` - Use this if you want to reproduce LDB agents that use a seed generated with Reflexion. The resulting folder containing the outputs and logs will follow the nomenclature **model**+reflexion.

    ```bash
    cd ./programming
    ./run_ldb_reflexion_seed.sh humaneval [model] [seedmodel]
    ```
    **Note:** This assumes that the respective seed is already in the output_data directory at the appropriate location in the `reflexion/` directory.


### To run LATS agents

 `LATS` - This reproduces our runs of the LATS agents. 

```bash
cd ./programming
./run_lats_humaneval.sh [model] [nr_int_tests]
```
**Note:** We learned from correspondence with the original authors, that the number of internal test cases was set to 6 for GPT-3.5 and 4 for GPT-4, respectively. The blog post has more details.

### To run Reflexion agents

 `Reflexion` - This reproduces our runs of the Reflexion agents.

```bash
cd ./programming_runs
./run_reflexion_humaneval.sh [model]
```
