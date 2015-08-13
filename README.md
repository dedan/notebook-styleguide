# Styleguide Readme

This readme is the Bayes Impact notebook styleguide and the rest of the repository serves as an example of its application. If you have any suggestions of how to improve this styleguide, we are happy to receive pull requests.

In order to run the code (mainly notebooks) in this repo you have to follow these steps

* install python dependencies by running `pip install -r requirements.txt`
* install the external dependency graphviz by using your favorite package manage, e.g.: on a mac `brew install graphviz`


## TL;DR

Write your notebooks in a way that they are fun to read. Don't make any assumptions on the knowledge of your reader, neither on the familarity with the subject. Always make your intentions explicit. Don't find the *smartest* way to compute something, find the most readable way. A notebook is a place to communicate results. To other people or to your future self. So make their life as nice as possible. It should feel totally effortless to read a notebook and the analysis should seem simple. Avoid all WTFs!


## project layout

* have a README file that gives someone new to the project all information that is necessary to start working
  - explain purpose of the project
  - where to find resources
  - project setup (external dependencies, makefile, etc)
* have all dependencies of a notebook specified in a requirements.txt file
* use relative paths to load your data from (no /Users/horst/projects/mepris/data/bla.csv)
* use a makefile to make data processing reproducable
  - if you applied some transformations to your dataset, record them in a makefile (or something similar). If not you'll mostly have no idea how you got the data in this format a few month later
* move larger chunks of code into a module and import it
  - this allows to share code between notebooks
  - the notebook should be used to communicate results, not its computation
  - makes the notebook more readable
* no unnecessary code and outdated notebooks


## style and formatting

* write pythonic and pandastic code
  - use iterators instead of indexes
  - use context managers
  - use pandas in a pandastic way (column level operations, group, map, filter)
* code style
  - generally follow pep8, people are used to read python code in this style
  - don't be too strict, notebooks are different
  - we don't suggest the hard 80 chars from pep8, but something in this range
  - move code with multiple levels of indentation into a helper module
  - it should be immediately clear what your code does
* markdown cells
  - add a markdown cell instead of a code cell with comments (nice formatting, links, etc)
  - use print statements only for data dependent text
* avoid unnecessary output
  - assign to _ in order to avoid unnecessary output (hist example)
  - limit the length of output when you want to show a few exemplary rows of a table (e.g.: df.head(20) instead of the first 50 rows)
  - don't commit notebooks that contain warnings or errors. When I open a notebook that contains a warning I start questioning the correctness of the results.
* import and configuration cell
  - no `import numpy as np` in your `~/.ipython/profile_default/startup/` folder (this guarantees that notebooks work on all machines, or at least fail explicitly in the imports section)
  - library initializations and configuration also into the initial cell
  - set constants in this cell (a path or URL that someone who uses your notebook might have to change)
* remove unused code!
  - unused imports
  - outdated code, cells, analysis
  - if code is for some reason commented out but you have a good reason to keep it, you should explicitly state this reason in the comment.


## storytelling

* use text to guide your reader through the notebook
  - explain in the beginning of a notebook what it is about
  - add a conclusion to the end of the notebook
  - explain all plots and results (in the moment you wrote the notebook it is probably clear what you were asking. But a month later not and for other people not at all)
  - always ask a question, write the code to answer it AND comment on the results
* start with some basic statistics to give the reader a feeling for the dataset
* use images or even video in your notebooks


## testing

* make sure that all your notebooks work in a fresh kernel

