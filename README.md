**Project Scope:**

I selected the "Football Wages Data" dataset from www.kaggle.com. This dataset contains the **2022** wage information for almost **3,900** players from **six European leagues**. The data was collected from the **Football Manager 2022** game, which is a popular tool used by football enthusiasts and professionals to simulate football management. My initial analysis involved exploratory data analysis, leading to hypothesis testing to understand the factors influencing player wages. The report focuses on the relationship between a player’s wage, league, position, and club and international appearances frequency.


**Research Questions**

**Q1)** At a 0.05 alpha, is there a statistically significant difference in average wages between defenders and midfielders?

**Q2)** At a 0.05 alpha, is there a statistically significant difference in average wages between the Premier League and Primiera Liga?

**Q3)** Does age, number of club appearances, and number of international appearances significantly predict the wages of football players in top European leagues?


**Exploratory Data Analysis**

The descriptive statistics indicate a median wage of $381,000 against an average of $1,139,612, indicating a skewed distribution. However, since the data appears to be skewed, the outliers identified by the box plot are not considered true outliers. Players' ages cluster around a median of 23, with a range from 18 to 41. The median club appearances stand at 111, with a majority having under 220 appearances. International appearances are less frequent, with a median of 0 and 75% of players having 5 or fewer caps. The Premier League and Primiera Liga are the most represented leagues, with defenders and midfielders being the most common positions.

The descriptive statistics reveal the financial complexities of European football, with wages varying widely, as evidenced by the significant skew in their distribution. Median values for age and club appearances hint at a cohort of players not yet at the peak of their careers, possibly reflecting the dynamic nature of the sport where emerging talents rise alongside established professionals. This diversity in career stages mirrors the financial stratification within the industry, where a few high earners may inflate average wage figures. Such disparities underscore the multifaceted economic environment that footballers navigate.

It is important to note that, despite the right skew in wage distribution, the dataset's size justifies parametric testing under the central limit theorem. This theorem indicates that for large samples, typically over 30, the mean will roughly follow a normal distribution, allowing for valid statistical analysis.


**Key Insights**

In the t-test comparing defenders' and midfielders' wages, the point estimate, reflecting the average wage difference, is $168,142, with midfielders earning more. The t-test yielded a t-value of -2.348 and a p-value of 0.01896, below the alpha level of 0.05, leading to the rejection of the null hypothesis. The 95% confidence interval ranges from approximately -$308,570 to -$27,714, affirming the significance of this wage disparity. This outcome suggests that the observed wage difference between these positions is statistically significant and not a result of random variation.

In the Welch two-sample t-test comparing Premier League and Primiera Liga wages, the point estimate for the average wage difference is approximately $1,814,414, with Premier League players earning more. The t-test gives a t-value of 22.483 and a p-value significantly less than 0.05, warranting a rejection of the null hypothesis. The 95% confidence interval, ranging from about $1,656,031 to $1,972,796, supports this significant wage difference. This finding confirms a statistically significant difference in wages between Premier League and Primiera Liga, highlighting the economic contrasts within European football.

The regression model further explores these relationships by quantifying the impact of each independent variable on wages. Each variable's impact on wages is statistically significant, as indicated by p-values far less than the alpha level of 0.05. This confirms that age, club appearances, and international appearances are all predictors of a player's wage within this dataset, with the data providing strong evidence against the null hypothesis that these variables have no effect. The model indicates that each additional year of age is associated with a decrease in wage by approximately $125,673, holding other factors constant. Conversely, both club and international appearances have a positive impact on wages, with each club appearance adding about $8,150 to a player’s wage and each international appearance adding around $32,100, suggesting that more on-field experience correlates with higher wages.

The 95% confidence intervals from the regression model provide ranges for each parameter's estimated value, offering a measure of their precision. For instance, the interval for 'age' suggests that each additional year is linked to a wage decrease between $150,430 and $100,915. Similarly, each extra club appearance could increase wages by $7,175 to $9,125, while each international appearance might add between $29,242 and $34,957 to wages. These intervals help gauge the reliability of the model's estimates, indicating the likely range within which the true values of these coefficients fall.

Overall the data analysis suggests a significant influence of playing position and league on wages, with midfielders and Premier League players earning higher wages. The regression model confirmed the positive impact of experience on wages, although it also indicated a potential peak wage age. These insights could inform contract negotiations and career management for players.


**Conclusion**

The analysis began by exploring the influence of age, playing position, league, and club and national appearances on players' wages. Utilizing hypothesis testing, the data revealed distinct financial patterns across positions and leagues. For instance, a two-tailed t-test demonstrated significant wage differences between defenders and midfielders, reflecting positional value disparities in European football. Similarly, a comparison between the Premier League and Primiera Liga wages highlighted the economic divides among leagues.

Regression analysis further quantified the impacts of age and appearance. The model indicated that each additional international appearance correlates with a wage increase, showcasing the premium on international experience. Age, had a subtler effect, suggesting that peak earning potential might not align strictly with age.

These findings narrate the economic story of European football, where market factors such as position, performance, and reputation interplay to determine a player's financial worth. Despite the range in wages and careers, the central limit theorem assured the robustness of this statistical journey, guiding the conclusions drawn from this diverse dataset.


