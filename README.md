# Styleguide

This README is the Bayes Impact notebook styleguide and the rest of the repository serves as an example of its application. If you have any suggestions of how to improve this styleguide, we are happy to receive pull requests.

Installation steps to run the code in this repository:

* install python dependencies by running `pip install -r requirements.txt`
* install the external dependency graphviz by using your favorite package manage, e.g.: on a mac `brew install graphviz`


## TL;DR

Write your notebooks in a way that they are fun to read. Don't make any assumptions on the knowledge of your reader, neither on the familiarity with the subject. Always make your intentions explicit. Don't find the *smartest* way to compute something, find the most readable way. A notebook is a place to communicate results. To other people or to your future self. So make their life as nice as possible. It should feel totally effortless to read a notebook and the analysis should seem simple. Avoid all WTFs!


## Project layout


### README

The README file should give someone new on the project all information that is necessary to start working. Oftentimes the setup of a project is not well documented. It is very demotivating if time has to be invested just to get the current code running. Therefore a README file should contain the following information:

* Explain the purpose of the project
* *ALL* steps that are required to get the code running! (dependencies, configuration)
* Add links to further resources (Dropbox with data, Asana with tasks, Slack channel, etc)


### requirements.txt

All python dependencies used in notebooks and modules should be kept in a [requirements.txt file](https://pip.pypa.io/en/latest/user_guide.html#requirements-files). This allows a user to install everything required by simply typing `pip install -r requirements.txt`.


### Central configuration

Configuration should be explicit and centralized. Avoid spreading configuration strings and values over several files. If settings are centralized they can be re-used from several notebooks and they are easy to be found. No complicated system is necessary for that, we often simply use a JSON file in the config folder (see example in [styleguide.ipynb](styleguide.ipynb)). Manual settings should be avoided when possible. For example an explicit path that only works on a specific machine could be replaced by a relative path (`/Users/horst/projects/mepris/data/bla.csv` -> `data/bla.csv`).


### Automated build system

When working with external datasets we often have to execute several steps of processing before we can work with them. I just recently had a case, working with geodata, where I downloaded shapefiles, unzipped them, converted them to GeoJSON while filtering on a property and in the end, converted everything to TopoJSON. Already a day later I had no idea what all the steps were to create my dataset that I plotted. Then I remembered that Mike Bostock, the creator of D3, often uses Makefiles in his examples and even wrote [an article](http://bost.ocks.org/mike/make/) about why we should use them.

* they automate the data processing workflow
* and at the same time document what we did

[Here](Makefile) is the example of a makefile I used to do all the steps described above. If I now want to recreate my dataset from scratch (even including the download), I just have to run `make clean` and `make all`. Of course any other build system like [waf](https://waf.io/) or [rake](https://github.com/ruby/rake) is equally fine. I mention make for its simplicity and widespread usage.


### Use modules for larger chunks of code

Notebooks are an excellent tool to communicate results and their computation. However when they contain too much code, they quickly become unreadable. We often saw that people forget all the common practices of writing good code, like encapsulation and separation of concerns, when they write notebooks. Verbose, repetitive code has a negative impact on the readability of notebooks. Simply moving code into a function and giving it a descriptive name makes notebooks much more pleasant to read. Move these functions into normal python modules and import them in the beginning of your notebook. This additionally has the big advantage that code can be shared between different notebooks and automated tests can be written for these functions.

TODO: add example


### Clean codebase

In one sentence: delete all unnecessary and unused code! This might sound self-evident, but we saw many notebooks with old code that was commented out. Or imports that were not used anymore. Some cells that compute something, but the result is not used anymore. This is very confusing for a reader of your notebook. I always feel unconfident changing a notebook when there is code which use is not immediately evident to me. Just delete it! When code is commented out and has to be kept for some reason, clearly state that reason in a comment.

Also delete all notebooks that are not used anymore. I recently spent quite some time understanding and using a notebook, just to find later that its functionality got replaced by a new one with a slightly different name. If one notebook replaces another and the old one is not used anymore, delete it. If two notebooks do almost the same, merge them. Be reasonable with the organization of your codebooks. They not only have to be readable by itself, they should also be consistent if a project contains a collection of notebooks.


### Testing

TODO: add small section that re-used code in modules should be tested and suggest a helper to run all notebooks to guarantee that they work in a fresh kernel


## Style and formatting


### Idiomatic code

Use Python in a way that people are used to read. Practice to write code in a *pythonic* way. And the same applies for pandas. Use it in a pandastic way.

* use iterators instead of indexes
* use context managers

TODO: add examples


### Code style

We generally suggest to follow the recommendations of [PEP8](https://www.python.org/dev/peps/pep-0008/). Thats what the community agreed on and thats what most people are used to read. However you should not be too strict or dogmatic with the application of this styleguide. Some of its rules don't make sense in notebooks. You don't always have to break a line at 80 characters. Still try to limit the length, a line like

`TODO: add example `

is not very readable. And when your line space becomes to small because you are at the 5th level of indentation, consider moving this code into a module. The most important thing is that it should be immediately clear what your code does. No magical long lines that apply ten different operations in one row, no cryptic variable names, no magic numbers.


### Markdown cells

Notebooks are an implementation of the idea of [literate programming](https://en.wikipedia.org/wiki/Literate_programming). The beauty of it is that you can mix code and text. Make use of it. Interweave your code cells me nicely formatted markdown cells. You can even use links, images or videos in it! As a general rule, if you want to display text that does not depend on computed values, use nice looking markdown cells.

Bad:
```
  print("First five customers")
  customers.head()
```

The text could also be in a markdown cell. Only use print statements for variable text like:

```
  print("The number of customers is {}".format(len(customers)))
```



### Avoid unnecessary output

Notebooks become hard to read when they are cluttered with output from cells. You should only show whats necessary to make your point. Pandas for example shows by default the first 50 rows of a DataFrame. But is that always necessary? If you just want to give an idea of how the data looks like, `df.head()` might be enough. Or if have a dataset with 40 columns, but only want to show that the name column contains numerical values, use `df['name'].head()` instead of the whole DataFrame. Some operations produce warning message. Take care of them, most of them appear for a reason. I immediately start questioning the validity of result if there are warning messages in a notebook. If you checked that the warning messages really does not affect the correctness of your analysis, add a comment to the line producing the warning. Don't display unnecessary return values, rather assign them to the anonymous variable `_`. For example many plotting functions return values that you don't need, but clutter the output of your cell. Write `_ = df.hist()` in such cases.


### Import and configuration cell

Start your notebooks with one import and configuration cell. When the reader of your notebook wonders where a certain constant or function comes from, he can always jump back to this cell in the beginning. Make sure that all imports are explicitly mentioned. It is tempting to have some standard imports like `import numpy as np` in your `~/.ipython/profile_default/startup/` folder, but this is annoying for people who want to run your notebook and don't have the exactly same configuration file. By having all imports explicitly it guarantees to work on all machines, or at least fail explicitly in the imports section. In this cell you should:

* explicitly import all libraries you use
* initialize DB connections or configure libraries
* define constants

TODO: add link to example notebook


## Storytelling


### Introduction

The previous two chapters are mostly prerequisites for the main usage of a notebook, to tell a story and communicate results. And this is also why a notebook should be more than a sequence of code cells and their output. You should use well written, concise text to guide your reader (which can always be yourself in the future) through the analysis. Start each notebook with a short introduction that gives some context and explains the purpose of the analysis. Sometimes this has to be a text of several paragraphs of background information, sometimes this is only a sentence like: "This notebook investigates the relationship between petal length and species of Iris flowers". This introduction should be followed by some basic statistics. Whats the size of your dataset, how many missing values does it have per column or what is the distribution of the main value you are interested in.


### Main analysis

To allow the reader to follow your thoughts you had when creating the notebook you should always repeat the three following steps during your main analysis.

1. Ask a question
2. Compute the answer in the form of numbers or a graph
3. Comment on the answer, state your interpretation

This might feel stupid in the beginning as the question and the interpretation of your results are clearly present in your mind. But you always have to consider that this does not mean that they are present to your readers head.


### Conclusion

In the beginning of your notebook you introduced its topic and stated the main question it is supposed to answer. The conclusion in the end should give an answer to this question, or the reason why it wasn't possible to find an answer to it. This allows a reader, who is not interested in all the technical details, to skip the whole analysis section and still get valuable information out of the notebook. And it helps you to focus on answering a question. The analysis is always only a means to answer a question. By always adding a conclusion you guarantee that you don't loose the focus of the question you initially asked.

