# bots-paper-repo
Anonymous repo for a paper in submission to CSCW 2018.

## Datasets
### Data dumps
This project begins with the the stub-meta-history.xml.gz dumps from the Wikimedia foundation. Note that these files are large -- approximately 85GB compressed -- and take a week parse on a 16 core Xeon workstation. As we are not taking issue with the way in which previous researchers have computationally identified reverts, replicating this step is not crucial. We recommend those interested in replication start with the revert datasets, described below.

### Revert datasets
Datasets in `datasets/revert_data/` include every bot-bot revert across pages in all namespaces for each language, generated from parsing the dumps by the scripts called in the `Makefile`. They are compressed using bzip2 and in TSV format. The format of these datasets can be seen in `analysis/0-load-process-data.ipynb`. Starting with these datasets in this repo lets you reproduce the novel parts of our analysis pipeline. Note that there are some duplicate rows in this dataset, which can be easily removed with a function like `df.drop_duplicates()` in pandas (this will be fixed in a future version).

### Processed datasets
Datasets in `datasets/processed_data/` are created out of the analyses in the Jupyter notebooks in the `analysis/` folder. If you are primarily interested in exploring our results and conducting further analysis, we'd recommend starting with `df_all_comments_parsed_2016.pickle.xz`. These datasets are compressed with xz (extremely compressed to keep them under GitHub's 100mb limit -- we will release many more common data formats when we can de-anonymize and use other platforms). The decompressed pickle file is a serialized pandas dataframe that can be loaded in python, as seen in the notebooks in the `analysis/paper_plots` folder.

- `df_all_2016.pickle.xz` is a pandas dataframe of all bot-bot reverts in the languages in our dataset. It is generated by running the Jupyter notebook `analysis/0-load-process-data.ipynb`, which also shows the variables in this dataset.

- `df_all_comments_parsed_2016.pickle.xz` extends `df_all_2016.pickle.xz` with classifications of reverts. It is generated by `analysis/6-1-comment-parsing.ipynb`, which also shows the variables in this dataset.

- `possible_botfights.pickle.bz2` and `possible_botfights.tsv.bz2` are bzip2-compressed filtered datasets of `df_all_comments_parsed_2016.pickle`, containing reverts from all langauges in our analysis that are possible cases of bot-bot conflict. 

### Bot datasets

- `datasets\crosswiki_category_bot_20170328.tsv` is generated from `get_category_bots.py` (also made in the `Makefile`) and contains a list of bots based on Wikidata categories for various language versions of Wikipedia's equivalent of [Category:All Wikipedia bots](https://www.wikidata.org/wiki/Q3681760)

- `datasets\crosswiki_unified_bot_20170328.tsv` is made in the `Makefile` and contains the above dataset combined with lists of bots from the `user_groups` and `former_user_groups` database tables ("the bot flag") in our seven language versions of Wikipedia. This dataset can be considered as complete of a list of current and historical bots (including unauthorized bots) as is possible to automatically generate for these language versions of Wikipedia.

## Analyses
### Analyses in the paper
Analyses that are presented in the paper are in the `analysis/paper_plots` folder, with Jupyter notebooks for each paper section (for example, section 4.2 on time to revert is presented in 4-2-time-to-revert.ipynb). Some of these notebooks include more plots than we were able to fit in the paper.
### Exploratory analyses
We also have various supplemental and exploratory analyses in `analyses/exploratory/`.

## Sample diff tables
These tables are accessible at [here](https://anon-cscw2018-author1.github.io/bots-paper-repo/sample_tables/) and were generated by `analysis/6-2-comments-sample-diffs.ipynb`.
