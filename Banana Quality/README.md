# Banana Quality
## Source Data
https://www.kaggle.com/datasets/mrmars1010/banana-quality-dataset

## Purpose
To analyze banana characteristics from various countries and determine which countries to import bananas based on banana needs.

## Tools
- Python (pandas, seabporn, matplotlib)
- Jupyter Notebook

## Findings:
- There are 8 countries exporting bananas: Brazil, Colombia, Costa Rica, Ecuador, Guatemala, Honduras, India, and Philippines

There are 8 types of bananas. The table below shows the average characteristics of each type:
*Bolded values represent the max value and italics represent the min value in each column*
| Banana Type | Avg. Quality Score | Avg. Weight (g) | Avg. Length (cm) | Ripeness Index | Suger Content (brix) | Firmness (kgf) |
|-------------|--------------------|-----------------|------------------|----------------|----------------------|----------------|
| Lady Finger | **2.53**               | 162.80          | 19.57            | **4.23**           | **18.86**                | 2.68           |
| Blue Java   | 2.52               | 164.62          | 20.75            | **4.23**           | 18.39                | 2.59           |
| Burro       | 2.51               | 164.90          | 20.41            | 4.06           | 18.62                | *2.52*           |
| Plantain    | 2.46               | 166.04          | 18.93            | 4.09           | 18.71                | 2.72           |
| Red Dacca   | 2.45               | 164.43          | 20.15            | 3.94           | 18.52                | 2.80           |
| Cavendish   | 2.43               | **170.63**          | *18.85*            | 4.05           | 18.56                | **2.82**           |
| Fehi        | 2.43               | *156.17*          | 19.87            | 4.03           | 18.26                | 2.73           |
| Manzano     | *2.39*               | 168.34          | **20.90**            | *3.72*           | *18.19*                | 2.77           |

- Lady Finger's have the highest average quality score of 2.53
- Cavendish are the heaviest banana type with an average weight of 170.63g
- Manzano banana's have the longest average length of 20.90cm
- Lady Finger and Blue Java are tied of having the highest average ripeness index of 4.23
- Lady Finger's have the most sugar content at 18.86brix
- Cavendish are the most firm bananas at 2.82kgf

Country Takeaways:
The following table shows each banana type and which country offers the best of the each characteristic
| Banana Type | Highest Avg. Quality Score | Longest Avg. Length (cm) | Heaviest Avg. Weight (g) | Highest Ripeness Index | Highest Sugar Content (brix) | Firmness (kgf) |
|-|-|-|-|-|-|-|
| Manzano | Guatemala, 2.59 | Honduras, 22.49 | Costa Rica, 184.75 | Honduras, 4.39 | Guatemala, 19.21 | Honduras, 3.29 |
| Plantain | Brazil, 2.62 | Brazil, 20.57 | Honduras, 184.85 | India, 4.6 | Colombia, 19.42 | Colombia, 3.41 |
| Burro | Costa Rica, 2.75 | Ecuador, 22.21 | Ecuador, 192.09 | Costa Rica, 4.72 | Colombia, 19.12 | Honduras, 2.97 |
| Red Dacca | Honduras, 2.73 | Guatemala, 21.73 | Colombia, 193.58 | Ecuador, 4.26 | Colombia, 19.56 | Guatemala, 3.27 |
| Fehi | Honduras, Philippines, 2.59 | Guatemala, 22.85 | Costa Rica, 170.29 | Honduras, 4.49 | Honduras, 18.76 | Costa Rica, 3.02 |
| Lady Finger | Costa Rica, 2.73 | Guatemala, 21.72 | Costa Rica, 182.41 | Brazil, 4.79 | India, 20.34 | Brazil, 3.11 |
| Blue Java | Guatemala, 2.68 | Honduras, 23.74 | India, 192.41 | Colombia, 4.75 | Costa Rica, 19.4 | Honduras, 2.89 |
| Cavendish | Brazil, 2.72 | Brazil, 21.13 | Costa Rica, 183.1 | Brazil, 4.77 | India, 19.2 | Brazil, 3.33 |

 

