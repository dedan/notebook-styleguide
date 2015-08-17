#!/usr/bin/env python
# encoding: utf-8
"""
Module with general helper functions we use at Bayes.

Created by Stephan on Aug 13, 2015.
"""
from IPython.display import HTML


def inline_map(m, width=650, height=500):
    """Use this function to embed a folium map directly in a notebook"""
    m._build_map()
    srcdoc = m.HTML.replace('"', '&quot;')
    embed = HTML('<iframe srcdoc="{}" '
                 'style="width: 100%; height: {}px; '
                 'border: none"></iframe>'.format(srcdoc, height))
    return embed
