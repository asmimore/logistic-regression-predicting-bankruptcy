# logistic-regression-predicting-bankruptcy
This project uses Logistic Regression method to predic bankruptcy.
## Features explain
1) Size

   a. Sales
  
2) Profit
   
   a. ROCE: Profit before tax to capital employed(%)
   b. FFTL: Funds flow(earnings before interest, tax & depreciation) to total liabilities

3) Gearing

    a. GEAR:(Current liabilities + long-term debt) to total assets
    b.CLTA: Current liabilities to total assets
    
4) Liquidity

    a. CACL: Current assets to current liabilities
    
    b. QACL: (Current assets - stock) to current liabilites
    
    c. WCTA: (Current assets - Current liabilities ) to total assets

5) LAG: number of days between account year end and the date the annual report and accounts were filed at company registry. 
6) AGE: number of years the company has been operating since incorporation date. 
7) CHAUD: coded 1 if changed auditor in previous three years, 0 otherwise 
8) BIG6: coded 1 if company auditor is a Big6 auditor, 0 otherwise 

## Result Interpret
The target variable is FAIL, 1: Bankruptcy, 0: Survive
