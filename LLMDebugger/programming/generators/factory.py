from .py_generate import PyGenerator
from .model import CodeLlama, ModelBase, GPT4, GPT35, StarCoder
import logging

def model_factory(model_name: str, port: str = "", key: str = "", logger: logging.Logger = None) -> ModelBase:
    if "gpt-4" in model_name:
        return GPT4(model_name, key, logger=logger)
    elif "gpt-3.5" in model_name:
        return GPT35(model_name, key, logger=logger)
    elif model_name == "starcoder":
        return StarCoder(port, logger=logger)
    elif model_name == "codellama":
        return CodeLlama(port, logger=logger)
    else:
        raise ValueError(f"Invalid model name: {model_name}")
