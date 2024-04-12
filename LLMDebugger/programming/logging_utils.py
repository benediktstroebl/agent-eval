import json
import logging

class JsonFormatter(logging.Formatter):
    def format(self, record):
        # Create a log record dictionary
        log_record = {
            "name": record.name,
            "level": record.levelname,
            "message": record.getMessage(),
            "time": self.formatTime(record, self.datefmt),
        }
        
        # Add any additional attributes you want in the log record
        if hasattr(record, 'input_messages'):
            log_record['input_messages'] = record.input_messages
        # Add any additional attributes you want in the log record
        if hasattr(record, 'output_messages'):
            log_record['output_messages'] = record.output_messages
        if hasattr(record, 'inference_time'):
            log_record['inference_time'] = record.inference_time
        if hasattr(record, 'task_id'):
            log_record['task_id'] = record.task_id
        if hasattr(record, 'performance'):
            log_record['performance'] = record.performance
        
        return json.dumps(log_record)
