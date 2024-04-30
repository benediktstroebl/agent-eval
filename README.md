# Repository to blogpost: AI leaderboards are no longer useful. It's time to switch to Pareto curves.

This repo holds the code, demos, and log files for the blogpost with the title [AI leaderboards are no longer useful. It's time to switch to Pareto curves.](https://www.aisnakeoil.com/) by Sayash Kapoor, Benedikt Stroebl, and Arvind Narayanan. 

Part of the analysis for this blogpost builds on the following three publications and their accompanying code repositories, which we used for reproducing their work.

[Reflexion: Language Agents with Verbal Reinforcement Learning](https://arxiv.org/abs/2303.11366) ([GitHub](https://github.com/noahshinn/reflexion/blob/main/programming_runs/simple.py))

[LDB: A Large Language Model Debugger via Verifying Runtime Execution Step by Step](https://arxiv.org/abs/2402.16906) ([GitHub](https://github.com/floridsleeves/llmdebugger))

[Language Agent Tree Search Unifies Reasoning Acting and Planing in Language Models](https://arxiv.org/abs/2310.04406) ([GitHub](https://github.com/andyz245/LanguageAgentTreeSearch))

### General notes on this repository

#### Structure

    - The repository is structured such that each high-level agent has their own directory, which resembles the original repositories of the respective paper
    - In addition, our baseline agents are building on top of the code of LDB and are thus contained in the LLMDebugger directory
    - Each of the three high-level directories contains a folder `output_data`, which containes the result logs of the experiments we ran
    
#### Logging

    - In order to log inference times and cost of the agents, we added code at the appropriate locations in the source code. The resulting log files are stored with the results from solving the HumanEval tasks in the `output_data` folder that is part of each agent directory. 
    - Note on interrupted runs: Some runs where interrupted and restarted at point where we left off to save cost, acc in LATS jsonl files not accurate in those cases, in order to reproduce unmodified files one can simply rerun a run from scratch

#### Changes made to source code of agent papers

In order to reproduce the work of the publications mentioned above and to fix issues, we had to make changes to the original code as provided by the authors. All of these changes are part of the commit history of this repository and can be inspected transparently.

#### Contact

For all questions, contact [sayashk, stroebl, arvindn]@princeton.edu

## Running agents and models

To get started:

1. Clone this repo and move to the HotPotQA directory:
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



### To run LDB agents

#### To run simple models and baselines

- `Simple models` -  This uses the simple strategy implemented in the code accompanying the LDB agent for zero-shot evaluations of language models (i.e., there is no agent architecture).

    ```bash
    cd ./programming
    ./run_simple.sh humaneval [model] [output_dir]
    ```

 - `Escalation` - We modify the simple strategy of LDB but switch the underlying model to a more expensive one if a proposed solution fails at least one of the example tests. Running the script below, will start five runs with llama-3-8b-chat-hf, gpt-3.5-turbo-0125, ​​llama-3-70b-chat-hf, gpt-4-turbo-2024-04-09 as backend fallback models.

    ```bash
    cd ./programming
    ./run_simple_boosting.sh humaneval [name_you_can_set]
    ```

 - `Retry` - Simple strategy that repeatedly prompts the same language model, keeping all parameters equal across retrials, as long as the code outputted by the model failed at least one of the example tests.

    ```bash
    cd ./programming
    ./run_simple_repeat.sh humaneval [model] [name_you_can_set]
    ```

 - `Warming` - For the warming baseline, we modify the Retry baseline by gradually increasing the temperature parameter across successive trials.

    ```bash
    cd ./programming
    ./run_simple_incr_temp.sh humaneval [model] [name_you_can_set]
    ```

#### To run LDB agents

 - `LDB with seed from simple strategy` - Use this if you want to reproduce LDB agents that do not use a seed generated with Reflexion. The resulting folder containig the outputs and logs will follow the nomenclature **model**+**seedmodel**.

    ```bash
    cd ./programming
    ./run_ldb.sh humaneval [model] [seedmodel]
    ```
    **Note:** This assumes that the respective seed is already in the output_data directory at the appropriate location.

 - `LDB with Reflexion seed` - Use this if you want to reproduce LDB agents that use a seed generated with Reflexion. The resulting folder containig the outputs and logs will follow the nomenclature **model**+reflexion.

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
**Note:** We learned from correspondence with the original authors, that the number of internal test cases was set to 6 for GPT-3.5 and 4 for GPT-4, respectively. For more details, refer to blogpost.


### To run Reflexion agents

 `Reflexion` - This reproduces our runs of the Reflexion agents.

```bash
cd ./programming
./run_reflexion_humaneval.sh [model]
```

## Another Note

Due to the nature of these experiments, it may not be feasible for individual developers to rerun the results as GPT-4 has limited access and significant API charges. All runs from the paper and additional results are logged in `./alfworld_runs/root` for decision-making, `./hotpotqa_runs/root` for reasoning, and `./programming_runs/root` for programming

## Other Notes

Check out the code for the original code [here](https://github.com/noahshinn/reflexion-draft)

Read a blog post [here](https://nanothoughts.substack.com/p/reflecting-on-reflexion)

Check out an interesting type-prediction implementation here: [OpenTau](https://github.com/GammaTauAI/opentau)

For all questions, contact [noahrshinn@gmail.com](noahrshinn@gmail.com)
