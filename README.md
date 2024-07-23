# SQL-Portfolio
**I have a genuine interest in analyzing data. I know I am not an expert but since I have an interest in data analysis, I am ready to learn as much as I can**. With that being said, this repository contains SQL queries on various datasets in a Postgres database. I use pgAdmin4 as my Postgres GUI and Git by running commands on PowerShell to upload my queries to GitHub.

When performing an analysis for a given dataset I follow the **OSEMN** methodology. Below I explain how I go about this methodology.

### 1. **O**btain
- I find datasets on Kaggle, government websites or anywhere I can and download them as **.csv** files. When selecting datasets I try to select the ones that are official and have been published for public use.
- To load the dataset into pgAdmin4, I create a new database and a table matching the columns and datatypes of the dataset and finally I import.
### 2. **S**crub
- I create a copy of the original dataset and perform my cleaning on the copy.
- Drop columns I don't need.
- Remove duplicates or irrelevant rows.
- Fix structural errors like typos, naming conventions, inconsistent strings, etc.
- Handle and/or replace missing values.
- Document all the steps I have taken to achieve this clean state.
### 3. **E**xplore
- This is where I begin writing queries to find the answers to some of the questions I brainstormed and get a better understanding of the data.
- I aggregate the data to find percentages, sums, max and min values, and more
### 4. **M**odel
- This portion I usually skip because I don't really have any models I run my data through. If I do, the model wasn't made by me...
### 5. i**N**terpret
- I record all my findings, summarize them, and make future recommendations.
- I use **Power BI** to visualize my findings for better understanding and for easy reporting to others.

You can find the SQL queries in the respective project folders and some of my project findings below.

# Projects
1. [NBA Stats 2012-2023](## 1. NBA Stats 2012-2023)
2. [Toronto Auto Theft 2014-2023](## 2. Toronto Auto Theft 2014-2023)
3. [Video Game Sales 1977-2020](## 3. Video Game Sales 1977-2020)

## 1. NBA Stats 2012-2023
### Source Data
https://www.kaggle.com/datasets/justinas/nba-players-data

### Purpose
To determine top performers in categories like scoring, assists, rebounds, and other categories.

### Findings:
1. In the NBA, the average player height is around 200cm or approximately 6'7 consisting of 67 nationalities.
2. In the 2022-23 season, the top 3 players with the highest ppg are Joel Embiid (PHI) 33.1 ppg, Luka Doncic (DAL) 32.4 ppg, and Damian Lillard (POR) 32.2 ppg.
3. In the 2022-23 season, the top 3 players with the highest rpg are Anthony Davis(LAL) 12.5 rpg, Domantas Sabonis (SAC) 12.3 rpg, and Giannis Antetokounmpo (MIL) 11.8 rpg.
4. In the 2022-23 season, the top 3 players with the highest apg are James Harden (PHI) 10.7 apg, Tyrese Haliburton (IND) 10.4 apg, and Trae Young (ATL) 10.2 apg

## 2. Toronto Auto Theft 2014-2023
### Source Data
https://data.torontopolice.on.ca/datasets/TorontoPS::auto-theft-open-data/about

### Purpose
With the continuous rise of auto theft crimes in Toronto and within the GTA, it would be a good idea to take the public dataset provided by the Toronto Police Department and gain some insights in the rise of thefts per year and location hotspots.

### Findings:
1. Parking lots are the number one location of thefts between 2014-19 and 2023, while homes were the number one location between 2020-22
2. From 2014-2023 auto thefts occured 34.2% in Parking Lots, 32.0% in Single Home, House (Attach Garage, Cottage, Mobile), and 18.5% in Streets, Roads, Highways (Bicycle Path, Private Road)
3. Starting in 2016, the change in auto theft percentage per year is always an increase and in the double digits
   - 2016-17: +16.89%
   - 2017-18: +22.81%
   - 2018-19: +20.87%
   - 2019-20: +10.91%
   - 2020-21: +18.02%
   - 2021-22: +34.75%
   - 2022-23: +12.49%
5. In 2014, a total of 3536 auto thefts occurred with 27.7% in residential areas while 8.0% in commercial areas. In 2023 a total of 11517 thefts occurred with 38.8% in residential areas while 7.7% in commercial areas. 
6. 1 West Humber-Clairville ranks as the number 1 neighbourhood with the most auto thefts from 2014-2023 with 130 Milliken and 159 Etobicoke City Centre ranking 2 and 3 respectively in 2023.


## 3. Video Game Sales 1977-2020
### Source Data
https://www.kaggle.com/datasets/asaniczka/video-game-sales-2024/data

### Purpose
Almost every person in the newer generations love to play video games. This dataset taken from Kaggle is used to find out what are the top selling games/franchises, publishers, genres, and more.

### Findings:
1. Top 10 best sellers include only 3 franchises, Grand Theft Auto, Call of Duty, Elder Scrolls, with Call of Duty accounting for 7/10 top sellers
2. Activision (Publisher of Call of Duty) has the highest global sales out of all publishers with 722.77 million copies sold which accounts for 16.02% of global sales while Ubisoft comes in at a close second with 14.58% of global sales
3. PS2 ranks as the number 1 platform for games to be purchased with 1.028 billion titles sold accounting for 15.6% of all sales, followed by number 2 Xbox 360 at 13.0%, number 3 PS3 at 12.7%, number 4 PS1 at 8.3%, and number 5 PS4 at 8.2%. Sony's Playstation is the more popular platform beating out Microsoft's Xbox.
4. The best selling platforms for each region are: Xbox 360 - NA region, PS3 - PAL region, PS1 - Japan, PS2 - Rest of World
5. Sports games are the number 1 selling game genre with 1187.51 million titles sold, followed by Action games, then Shooters
