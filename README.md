# SmallWorldAssessment

**Small World Assessment** is a MATLAB function for the analysis of various parameters related to small-worldness in undirected networks.

SmallWorldAssessment was created by Dylan Terstege, a Neuroscience PhD candidate in the Epp Lab at the University of Calgary.

## Table of Contents

| Section  | Description | 
| ------------- | ------------- | 
| [1. Limitations and Definitions](#limits)   | What are we assessing  |
| [2. Variable Definitions](#vars)   | Description of input and output variables  |
| [3. Citation](#cite) | How to cite the Targeted Node Deletion Toolbox |
| [4. Contact Us](#contact)  | Where to reach us with questions  |

<a name="limits"/>

## 1. Limitations and Definitions

The current analyses do not measure a true small world coefficient, as is defined by [Humphries (2008)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0002051), but rather approximates based on the criteria shown in [Wheeler (2013)](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002853).

This function allows for an assessment of "small-world-like" properties in networks in which not all components are connected.  Attempting to apply the Humphries definition to such networks would not work, as the shortest path between non-connected nodes is infinite.

To circumvent this issue, we assess small worldness in terms of integration via global efficiency and segregation via mean clustering coefficients.

These values are then compared to random graphs, which are matched with the input graph for degree distribution

<a name="vars"/>

## 2. Variable Definitions

The function is as follows:

```Matlab
[SW,D,C,CR,E,ER] = smallworldassessment(cor,thresh)
```

The input and output variables are defined as follows:

**Inputs**

- **cor**: input correlation matrix representing the matrix.  Must be formatted as a double.  Its dimensions must be square.
- **thresh**: (optional input) the threshold which will be used to binarize the correlation matrix.  Any value greater than or equal to this value will be set to 1, while anything less than this value will be set to 0.  The default value for this parameter is 0.8.

**Outputs**

- **SW**: the results of the analysis. TRUE or FALSE; the network does or does not display Small World-like Characteristics
- **D**: the distribution of degrees in the input matrix.  The vector is organized in the same order as the input matrix.
- **C**: a vector listing the clustering coefficient of each node in the input matrix.
- **CR**: a vector listing the clustering coefficient of each node in the random matrix.
- **E**: a vector listing the bootstrapped global network efficiency of the input matrix.  In this case, the global network efficiency is defined as the inverse of the mean shortest path length between all sets of nodes in the network.
- **ER**: a vector listing the bootstrapped global network efficiency of the random matrix.  In this case, the global network efficiency is defined as the inverse of the mean shortest path length between all sets of nodes in the network.

<a name="cite"/>

## 3. Citation

If you find the SmallWorldAssessment to be useful, and apply it in your research, please cite the following [article](https://www.biorxiv.org/content/10.1101/2021.03.28.437394v1) in which we first use these analyses:

Terstege DJ, Durante IM, Epp JR, Brain-wide neuronal activation and functional connectivity are modulated by prior exposure to repetitive learning episodes.

<a name="contact"/>

## 4. Contact Us

**Contributors:**
- **Dylan Terstege*** (code/tool conceptualization/written documentation) - ![twitter-icon_16x16](https://user-images.githubusercontent.com/44174532/113163958-e3d3e400-91fd-11eb-8d79-17906d8d3f25.png)[@dterstege](https://twitter.com/dterstege) - ![Mail](https://user-images.githubusercontent.com/44174532/113164412-50e77980-91fe-11eb-9282-dd83852578ce.png)
<dylan.terstege@ucalgary.ca>


Principal Investigator:
- Jonathan Epp (tool conceptualization) - https://epplab.com

<sub><sup>***corresponding author**</sup></sub>

