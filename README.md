**Project Scope:**

I selected the "Football Wages Data" dataset from www.kaggle.com. This dataset contains the **2022** wage information for almost **3,900** players from **six European leagues**. The data was collected from the **Football Manager 2022** game, which is a popular tool used by football enthusiasts and professionals to simulate football management. My initial analysis involved exploratory data analysis, leading to hypothesis testing to understand the factors influencing player wages. The report focuses on the relationship between a player’s wage, league, position, and club and international appearances frequency.


**Key Insights**

The descriptive statistics indicate a median wage of $381,000 against an average of $1,139,612, indicating a skewed distribution. However, since the data appears to be skewed, the outliers identified by the box plot are not considered true outliers. Players' ages cluster around a median of 23, with a range from 18 to 41. The median club appearances stand at 111, with a majority having under 220 appearances. International appearances are less frequent, with a median of 0 and 75% of players having 5 or fewer caps. The Premier League and Primiera Liga are the most represented leagues, with defenders and midfielders being the most common positions.

The descriptive statistics reveal the financial complexities of European football, with wages varying widely, as evidenced by the significant skew in their distribution. Median values for age and club appearances hint at a cohort of players not yet at the peak of their careers, possibly reflecting the dynamic nature of the sport where emerging talents rise alongside established professionals. This diversity in career stages mirrors the financial stratification within the industry, where a few high earners may inflate average wage figures. Such disparities underscore the multifaceted economic environment that footballers navigate.

It is important to note that, despite the right skew in wage distribution, the dataset's size justifies parametric testing under the central limit theorem. This theorem indicates that for large samples, typically over 30, the mean will roughly follow a normal distribution, allowing for valid statistical analysis.


**Conclusion**

The analysis began by exploring the influence of age, playing position, league, and club and national appearances on players' wages. Utilizing hypothesis testing, the data revealed distinct financial patterns across positions and leagues. For instance, a two-tailed t-test demonstrated significant wage differences between defenders and midfielders, reflecting positional value disparities in European football. Similarly, a comparison between the Premier League and Primiera Liga wages highlighted the economic divides among leagues.

Regression analysis further quantified the impacts of age and appearance. The model indicated that each additional international appearance correlates with a wage increase, showcasing the premium on international experience. Age, had a subtler effect, suggesting that peak earning potential might not align strictly with age.

These findings narrate the economic story of European football, where market factors such as position, performance, and reputation interplay to determine a player's financial worth. Despite the range in wages and careers, the central limit theorem assured the robustness of this statistical journey, guiding the conclusions drawn from this diverse dataset.


