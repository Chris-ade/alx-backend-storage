#!/usr/bin/env python3
"""
schools by topics
"""


def schools_by_topic(mongo_collection, topic):
    """
    This function returns a list of schools that have a specific topic.
    """
    schools = []
    cursor = mongo_collection.find({"topics": topic})
    for document in cursor:
        schools.append(document)
    return schools
