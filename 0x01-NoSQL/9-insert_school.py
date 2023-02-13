#!/usr/bin/env python3
"""
This module inserts a document based on kwargs
"""


def insert_school(mongo_collection, **kwargs):
    """
    This function inserts a new document in a collection
    based on keyword arguments.
    """
    result = mongo_collection.insert_one(kwargs)
    return result.inserted_id
