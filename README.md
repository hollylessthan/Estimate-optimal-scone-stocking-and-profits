# Estimate-optimal-scone-stocking-and-profits

This is a course project from Supply Chain Analytics course at UCSD, and the data is from the course as well.

In this project, I applied a data-driven analytics to estimate the optimal stocking level that will bring optimal profit for a scone bakery.

I first explored the daily scone demand data and examined its distribution. Because there was an outlier in the data, I modified it before starting the analysis.

I then calculated the profit matrix. To be more specific, the range of the daily demand is from 3 to 18, so I set the stocking levels to be 3 to 18 per day and  calculated the daily profits for each level. Assuming that the price of a scone is $2.49, the cost of a scone is 1.24, and the salvage value per scone is 0.99 (the clear-out price if leftover). I got a 16* 365 dimension profit matrix profit. Each column of the profit matrix is a stocking level (from 3 to 18, a total of 16 levels), and each row represents the profit for one of the 365-day demands.

Moreover, I averaged the profit expected to earn and estimated the standard deviation of the profit from the profit matrix. Because the only thing I cared about is to maximize the average profits, the optimal stocking amount should be set to 16 according to the calculation.

I also estimated the average safety stock for the scone bakery and the perfect forecasting system.

