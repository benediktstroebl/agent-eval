# Repository to blogpost: AI leaderboards are no longer useful. It's time to switch to Pareto curves.

This repository contains the accompanying code to the blogpost with the title [AI leaderboards are no longer useful. It's time to switch to Pareto curves.](https://www.aisnakeoil.com/) by Sayash Kapoor, Benedikt Stroebl, and Arvind Narayanan. 

Part of the analysis for this blogpost builds on the following three publications and their accompanying code repositories, which we used for reproducing their work.

**Reflexion ---**
[Reflexion: Language Agents with Verbal Reinforcement Learning](https://arxiv.org/abs/2303.11366) ([GitHub](https://github.com/noahshinn/reflexion/blob/main/programming_runs/simple.py))

**LDB ---**
[LDB: A Large Language Model Debugger via Verifying Runtime Execution Step by Step](https://arxiv.org/abs/2402.16906) ([GitHub](https://github.com/floridsleeves/llmdebugger))

**LATS ---**
[Language Agent Tree Search Unifies Reasoning Acting and Planing in Language Models](https://arxiv.org/abs/2310.04406) ([GitHub](https://github.com/andyz245/LanguageAgentTreeSearch))

### General notes

#### Structure

- This repository is organized so that each high-level agent has its own dedicated directory, mirroring the structure of the original repositories associated with the respective research papers.
- Additionally, our baseline agents are built upon the LDB codebase and are therefore housed within the LLMDebugger directory.
- Each of the three primary directories includes an `output_data/` folder, which contains the result logs from the experiments we conducted.
- The bash script referenced below for each agent can be found in the respective `programming` folder.
    
#### Logging

- To track inference times and costs associated with the agents, we added code at relevant points within the source code. The resulting log files are stored alongside the results from solving the HumanEval tasks in the `output_data/` subdirectories located within each agent directory.
- **Note on interrupted runs:** It's important to note that some experimental runs were interrupted and subsequently restarted from the point of interruption to conserve costs. In particular, the accuracy reflected in the LATS jsonl files may not be entirely precise in these instances. To reproduce unmodified files, simply re-run a specific experiment from the beginning.

#### Changes made to source code of agent papers

In order to reproduce the work of the publications mentioned above and to address encountered reproducibility issues, we had to make changes to the original code as provided by the authors. All of these changes are part of the commit history of this repository and can be inspected transparently. For more details on some of the reproducibility issues, please refer to the accompanying blog post.

#### Additional questions and details

We would like to direct all inquiries regarding this code and our implementations to the blog article and its associated appendices, which are more detailed. We have listed our contact information below in case you have any further questions after reading this.

#### Contact

For all questions, contact [sayashk, stroebl, arvindn]@princeton.edu

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

### To run LDB agents

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
