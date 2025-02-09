# Banana Quality
## Source Data
https://www.kaggle.com/datasets/mrmars1010/banana-quality-dataset

## Purpose
To analyze banana characteristics from various countries and determine which countries to import bananas based on banana needs.

## Tools
- Python (pandas, seabporn, matplotlib)
- Jupyter Notebook

## Findings:
- There are 8 countries to import bananas from: Brazil, Colombia, Costa Rica, Ecuador, Guatemala, Honduras, India, and Philippines
- The quality of a banana can be categorized by the quality score and is shown in the table below

| Quality Category | Quality Score |
|------------------|-------|
| Unripe | <= 1.50 |
| Processing | 1.51 - 2.50 |
| Good | 2.51 - 3.50 |
| Premium | > 3.50 |

- All regions produce a majority banana quality of  'Processing' and 'Good'
- There are 8 banana types. The table below shows several attributes:

| Banana Type | Avg. Quality Score | Avg. Weight (g) | Avg. Length (cm) |  
|-------------|--------------------|-----------------|------------------|
| Blue Java   | 2.52               | 164.62          | 20.75            |
| Burro       | 2.51               | 164.90          | 20.41            |
| Cavendish   | 2.43               | 170.63          | 18.85            |
| Fehi        | 2.43               | 156.17          | 19.87            |
| Lady Finger | 2.53               | 162.80          | 19.57            |
| Manzano     | 2.39               | 168.34          | 20.90            |
| Plantain    | 2.46               | 166.04          | 18.93            |
| Red Dacca   | 2.45               | 164.43          | 20.15            |

- It was discovered that the quality score of a banana is correlated to the length, sugar content, and ripness index.
- The ripeness of a banana can be categorized by the ripeness index and is shown in the table below

| Ripeness Category | Ripeness Index |
|------------------|-------|
| Green | <= 2.00|
| Turning | 2.01 - 4.00 |
| Ripe | 4.01 - 6.00 |
| Overripe | > 6.00 |

- All regions produce a bananas that are categorized as 'Turning' or 'Ripe' on the ripeness index.
 

