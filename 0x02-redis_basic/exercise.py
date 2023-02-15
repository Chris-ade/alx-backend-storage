#!/usr/bin/env python3
"""
Redis module
"""
import sys
from functools import wraps
from typing import Union, Optional, Callable
from uuid import uuid4

import redis

UnionOfTypes = Union[str, bytes, int, float]


def count_calls(method: Callable) -> Callable:
    """
    a system to count calls
    """
    key = method.__qualname__

    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """
        a simple wrapper
        """
        self._redis.incr(key)
        return method(self, *args, **kwargs)

    return wrapper


def call_history(method: Callable) -> Callable:
    """
    add its input parameters to one list
    """
    key = method.__qualname__
    i = "".join([key, ":inputs"])
    o = "".join([key, ":outputs"])

    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """ Wrapp """
        self._redis.rpush(i, str(args))
        res = method(self, *args, **kwargs)
        self._redis.rpush(o, str(res))
        return res

    return wrapper

def replay(func: Any) -> None:
    """ 
    Display the history of calls of a particular function 
    """
    redis_conn = redis.Redis()
    func_name = func.__name__
    keys = redis_conn.keys()
    calls = [key.decode('utf-8') for key in keys if key.decode('utf-8').startswith(func_name + ':')]

    print(f"{func_name} was called {len(calls)} times:")

    for call in calls:
        inputs = redis_conn.lrange(call + ':inputs', 0, -1)
        outputs = redis_conn.lrange(call + ':outputs', 0, -1)
        arg_strings = [arg.decode('utf-8') for arg in inputs]
        ret_strings = [ret.decode('utf-8') for ret in outputs]
        arg_list = [eval(arg_string) for arg_string in arg_strings]
        ret_list = [eval(ret_string) for ret_string in ret_strings]

        call_string = f"{func_name}(" + ", ".join(arg_strings) + ")"
        ret_string = ret_strings[0]

        print(f"{call_string} -> {ret_string}")

class Cache:
    """
    Cache redis class
    """

    def __init__(self):
        """
        constructor of the redis model
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    @count_calls
    @call_history
    def store(self, data: UnionOfTypes) -> str:
        """
        generate a random key
        """
        key = str(uuid4())
        self._redis.mset({key: data})
        return key

    def get(self, key: str, fn: Optional[Callable] = None) \
            -> UnionOfTypes:
        """
        convert the data back
        to the desired format
        """
        if fn:
            return fn(self._redis.get(key))
        data = self._redis.get(key)
        return data

    def get_int(self: bytes) -> int:
        """get a number"""
        return int.from_bytes(self, sys.byteorder)

    def get_str(self: bytes) -> str:
        """get a string"""
        return self.decode("utf-8")
