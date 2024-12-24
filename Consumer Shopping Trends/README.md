# Consumer Shopping Trends
## Source Data
https://www.kaggle.com/datasets/bhadramohit/customer-shopping-latest-trends-dataset

## Purpose
To identify trends in consumer retail purchasing

## Tools
- SQL
- pgAdmin4

## Findings:

### General Stats
- The majority of the dataset contains consumers between the ages of 25-64

| Age Group | Count |
|-|-|
| 18-24 | 486 |
| 25-34 | 755 |
| 34-44 | 729 |
| 45-54 | 752 |
| 55-64 | 751 |
| 65+ | 427 |

- There are more male consumers than female consumers

| Gender | Count |
|-|-|
| Female | 1248 |
| Male | 2652 |

- All 50 states are represented in the dataset, Montana having the most consumer entries at 96, while Rhode Island has the least at 63

### Spending by Demographic

- Males spend an average of $59.54 USD while females spend an average of $60.25 USD
- The average spending between consumer age groups are close in value and barely have any differences. The average range of spending is between $58 - $60 for all age groups.

| Age Group | Average Spending ($ USD) |
|-|-|
| 18-24 | 60.20 |
| 25-34 | 60.13 |
| 34-44 | 59.62 |
| 45-54 | 60.33 |
| 55-64 | 58.72 |
| 65+ | 59.70 |

### Spending by Categories

- Clothing and accessories are the leading categories consumers choose to spend their money with a total spending of $104,264 and $74,200 respectively. It can be seen that the average spending for a consumer for each category is around $60. However, consumers choose to spend more money on buying clothing and accesories.

| Category | Total Spending ($ USD) | Average Spending ($ USD) | 
|-|-|-|
| Clothing | 104,264 | 60.03 |
| Accessories | 74,200 | 59.84 |
| Footwear | 36,093 | 60.26 |
| Outerwear | 18,524 | 57.17 |

- Since the top 2 categories consumers spend there money on are clothing and accessories, the top 10 items money is spent on will be of these categories. Some of the most bought clothing items are the blouse, shirt, and dress, while jewelry and sunglasses are some of the most bought for accessories.
  
| Category | Item | Total Amount Spent ($ USD) | Average Amount Spent ($ USD) |
|-|-|-|-|
| Clothing | Blouse | 10,410 | 60.88 |s
| Clothing | Shirt | 10,332 | 61.14 |
| Clothing | Dress | 10,320 | 62.17 |
| Clothing | Pants | 10,090 | 59.01 |
| Accessories | Jewelry | 10,010 | 58.54 |
| Accessories | Sunglasses | 9,649 | 59.93 |
| Accessories | Belt | 9,635 | 59.84 |
| Accessories | Scarf | 9,561 | 60.90 |
| Clothing | Sweater | 9,462 | 57.70 |
| Clothing | Shorts | 9,433 | 60.08 |

- The following list will display the item and category with highest average purchase amount for each gender in all age groups. This will give insights to what each gender of different ages prefer to spend their money on.

Males
- 18-24 Boots: $70.33
- 25-34 Shoes: $74.43 
- 35-44 Blouse: $78.27
- 45-54 Hat: $68.10
- 55-64 Jeans: $64.37
- 65+ T-shirt: $80.60

Females
- 18-24 T-shirt: $79.57
- 25-34 Jewelry: $72.00
- 35-44 Jewelry: $77.40
- 45-54 Hat: $76.40
- 55-64 Gloves: $79.67
- 65+ Boots $99.00

### Spending by Season

- There is no significant difference between spending during seasons. The total and average spendings for each season are very similar with the Fall season having the highest total and average purchase amount at $60,018 and $61.56 respectively. 

| Season | Total Purchase Amount ($ USD) | Average Purchase Amount ($ USD) |
|-|-|-|
| Fall | 60,018 | 61.56 | 
| Winter | 58,607 | 60.36 |
| Spring | 58,679 | 58.74 |
| Summer | 55,777 | 58.41 |

- The most commonly purchased item in the Fall is a jacket, in winter it is sunglasses, in Spring it is a sweater, and in Summer it is pants.

### Discounts and Promo Code Usage
- Discounts have no impact on the average amount spent by season. Usually, consumers will spend more on average when there a discount is used. However, the data shows this is not the case.
- 57% of consumers DO NOT use promo codes.
- Clothing is the category that uses the most promo codes during purchase while Outerwear is the least.



 

