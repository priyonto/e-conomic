# e-conomic
This repository contains the solution of e-conomic iOS Code Challenge
---

The task is to implement a simple iOS application that solves following problems: 

-  [x] Take photos of my expenses (receipts or invoices).
-  [x] Add information about the receipt (date, total, currency, etc) and store it locally
-  [x] Access the history of the photos taken (should be available offline) with the data I
inputed
-  [x] The app should work even if you are offline and should maintain its state after closing
-  [x] The solution must be thread safe and should be robust enough to handle large sets
of data.

---

The solution crafted keeping the above mentioned problems in mind and the challenge was to find the best user experience possible. While the solution solves these problems, this is perhaps not the best possible solution. There are always room for improvements. For example, while adding and deleting can be performed now, editing is not implemented. However, this app is built thinking simple UX yet powerful and extensive if the dataset grows with time. The thread safety is monitored in every class as well as memory is tuned. 

Overall, it was a nice coding challenge with a good opportunity to learn. 
