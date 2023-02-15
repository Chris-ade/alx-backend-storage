#!/usr/bin/env python3
"""
Cache module
"""

import redis
import uuid


class Cache:
    """
    Cache class that interacts with Redis
    """

    def __init__(self) -> None:
        """
        Initialize Cache instance
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: bytes) -> str:
        """
        Store the input data in Redis using a randomly generated key and
        return the key
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key
