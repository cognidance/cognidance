The 'horizon task' is a psychology game used to study human behavior
during the explore-exploit dilemma (Wilson et al., 2014).

A special property of this task is its dissociation of directed and random
exploration, two strategies that resolve the above dilemma. Evidence suggests
both are deployed by healthy adults and children (Wilson et al., 2020), and has
detected behavioral changes coinciding with neuronal alternations, e.g., rTMS
to the prefrontal cortex (Zajkowski et al., 2017) or a schizophrenia diagnosis
(Waltz et al., 2020).

Instructions to run the experiment on PsyToolkit and to run the model-free
analysis  on MATLAB (adapted from Zajkowski et al., 2017) are included below.

1. Running the 'horizon task'

Upload the file 'horizon_task_48_games.zip' to the Experiment section in
PsyToolkit (NOT to the Survey section). To run the task, compile in the Survey
section along with other information for your experiment (e.g., your consent
request, ethics info, etc.). Set your Survey to start online data collection,
and share the link to your Survey with your participants. Data is automatically
saved on PsyToolkit when subjects finish the task.

2. Data analysis (model-free)

After subjects complete the task, download your data from PsyToolkit. Save the
files with the task data alongside the MATLAB scripts named 'load_data.m' and
a data file named '20210604_for_psytoolkit.mat.' In MATLAB, run the
'behavioral_analysis.m' script (confirming that the file to your data is
correct).

This will generate some useful figures that are similar to Zajkowski et al. (2017), 
but for your online data. :)

3. Adapting for your own game size

To adapt my scripts and add or remove games (instead of 48 or 72), I included the MATLAB
scripts 'task_parameters_48GAMES.m' and 'task_parameters_72GAMES.m.' Running these in 
MATLAB will generate the necessary parameters for your task - simply adjust for your 
preferred number of games in the task. 

The parameter protocol was based on  Waltz et al. (2020) and Wilson et al. (2014). Its 
intent is to de-correlate the value and information confound that is problematic in 
paradigms testing for the explore-exploit dilemma. Correlation values of these task 
parameters in your data are shown in "Figure 1" after running the 'behavioral_analysis.m' 
script in MATLAB.

References

Waltz JA, Wilson RC, Albrecht MA, Frank MJ, Gold JM (2020). Differential Effects
of Psychotic Illness on Directed and Random Exploration. Computational
Psychiatry, 4, 18-39.

Wilson RC, Bonawitz E, Costa VB, & Ebitz RB (2020). Balancing exploration and
exploitation with information and randomization. Current Opinion in Behavioral
Science, 38, 49-56.

Wilson RC, Geana A, White JM, Ludvig EA, Cohen JD (2014). Humans Use Directed
and Random Exploration to Solve the Explore–Exploit Dilemma. Journal of
Experimental Psychology, 143, 2074-2081.

Zajkowski WK, Kossut M, & Wilson RC (2017). A causal role for right frontopolar
cortex in directed, but not random, exploration. eLife, 6, 1-18.
