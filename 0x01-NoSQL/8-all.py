#!/usr/bin/env python3
"""
This module lists all documents in a collection.
"""


def list_all(mongo_collection):
    """
    This function lists all documents in a collection.
    """
    documents = []

    for document in mongo_collection.find({}):
        documents.append(document)

    return documents
