#======================================================================================
# load libraries
#======================================================================================
import os
import numpy as np
import pandas as pd
from pathlib import Path
import matplotlib.pyplot as plt

#======================================================================================
# process and merge data
#======================================================================================
cr_all = pd.read_stata('./data/resdata_final_age_all_cr.dta')
cr_all['rate_cr_all'] = cr_all['rate']
cr_all['mrate_cr_all'] = cr_all['mrate']
cr_all = cr_all[['countyfips', 'year', 'rate_cr_all', 'mrate_cr_all']]

cv_all = pd.read_stata('./data/resdata_final_age_all_cv.dta')
cv_all['rate_cv_all'] = cv_all['rate']
cv_all['mrate_cv_all'] = cv_all['mrate']
cv_all = cv_all[['countyfips', 'year', 'rate_cv_all', 'mrate_cv_all']]

cr_0_1 = pd.read_stata('./data/resdata_final_age_0_1_cr.dta')
cr_0_1['rate_cr_0_1'] = cr_0_1['rate']
cr_0_1['mrate_cr_0_1'] = cr_0_1['mrate']
cr_0_1 = cr_0_1[['countyfips', 'year', 'rate_cr_0_1', 'mrate_cr_0_1']]

cv_0_1 = pd.read_stata('./data/resdata_final_age_0_1_cv.dta')
cv_0_1['rate_cv_0_1'] = cv_0_1['rate']
cv_0_1['mrate_cv_0_1'] = cv_0_1['mrate']
cv_0_1 = cv_0_1[['countyfips', 'year', 'rate_cv_0_1', 'mrate_cv_0_1']]

cr_1_14 = pd.read_stata('./data/resdata_final_age_1_14_cr.dta')
cr_1_14['rate_cr_1_14'] = cr_1_14['rate']
cr_1_14['mrate_cr_1_14'] = cr_1_14['mrate']
cr_1_14 = cr_1_14[['countyfips', 'year', 'rate_cr_1_14', 'mrate_cr_1_14']]

cv_1_14 = pd.read_stata('./data/resdata_final_age_1_14_cv.dta')
cv_1_14['rate_cv_1_14'] = cv_1_14['rate']
cv_1_14['mrate_cv_1_14'] = cv_1_14['mrate']
cv_1_14 = cv_1_14[['countyfips', 'year', 'rate_cv_1_14', 'mrate_cv_1_14']]

cr_15_64 = pd.read_stata('./data/resdata_final_age_15_64_cr.dta')
cr_15_64['rate_cr_15_64'] = cr_15_64['rate']
cr_15_64['mrate_cr_15_64'] = cr_15_64['mrate']
cr_15_64 = cr_15_64[['countyfips', 'year', 'rate_cr_15_64', 'mrate_cr_15_64']]

cv_15_64 = pd.read_stata('./data/resdata_final_age_15_64_cv.dta')
cv_15_64['rate_cv_15_64'] = cv_15_64['rate']
cv_15_64['mrate_cv_15_64'] = cv_15_64['mrate']
cv_15_64 = cv_15_64[['countyfips', 'year', 'rate_cv_15_64', 'mrate_cv_15_64']]

cr_65 = pd.read_stata('./data/resdata_final_age_65_cr.dta')
cr_65['rate_cr_65'] = cr_65['rate']
cr_65['mrate_cr_65'] = cr_65['mrate']
cr_65 = cr_65[['countyfips', 'year', 'rate_cr_65', 'mrate_cr_65']]

cv_65 = pd.read_stata('./data/resdata_final_age_65_cv.dta')
cv_65['rate_cv_65'] = cv_65['rate']
cv_65['mrate_cv_65'] = cv_65['mrate']
cv_65 = cv_65[['countyfips', 'year', 'rate_cv_65', 'mrate_cv_65']]

out = (
    cr_all
      .merge(cv_all,   on=['countyfips', 'year'], how='left')
      .merge(cr_0_1,   on=['countyfips', 'year'], how='left')
      .merge(cv_0_1,   on=['countyfips', 'year'], how='left')
      .merge(cr_1_14,  on=['countyfips', 'year'], how='left')
      .merge(cv_1_14,  on=['countyfips', 'year'], how='left')
      .merge(cr_15_64, on=['countyfips', 'year'], how='left')
      .merge(cv_15_64, on=['countyfips', 'year'], how='left')
      .merge(cr_65,    on=['countyfips', 'year'], how='left')
      .merge(cv_65,    on=['countyfips', 'year'], how='left')
)
out.head()
sum = out[[c for c in out.columns if c.startswith('rate')]].describe().T

means = sum['mean']
df = pd.DataFrame({
    'age_groups': ['All-ages', '0-1', '1-14', '15-64', '65+'],
    'cr_values': [
        round(means['rate_cr_all'], 2),
        round(means['rate_cr_0_1'], 2),
        round(means['rate_cr_1_14'], 2),
        round(means['rate_cr_15_64'], 2),
        round(means['rate_cr_65'], 2),
    ],
    'cv_values': [
        round(means['rate_cv_all'], 2),
        round(means['rate_cv_0_1'], 2),
        round(means['rate_cv_1_14'], 2),
        round(means['rate_cv_15_64'], 2),
        round(means['rate_cv_65'], 2),
    ]
})
df

#======================================================================================
# plot
#======================================================================================
# Initialize figure and axes
fig, ax = plt.subplots(figsize=(10, 10))

# Define bar width and positions
x = np.arange(len(df['age_groups']))
bar_width = 0.4

# Plot bars for Chronic Respiratory Diseases
ax.bar(x - bar_width/2, df['cr_values'], width=bar_width, color='white', edgecolor='black', label='Chronic Respiratory (CR) Diseases')

# Plot bars for Cardiovascular Diseases
ax.bar(x + bar_width/2, df['cv_values'], width=bar_width, color='darkgray', edgecolor='black', label='Cardiovascular (CV) Diseases')

# Annotate bars with values
for i, v in enumerate(df['cr_values']):
    ax.text(i - bar_width/2, v + 30, f'{v:.2f}', ha='center', fontsize=12)
for i, v in enumerate(df['cv_values']):
    ax.text(i + bar_width/2, v + 30, f'{v:.2f}', ha='center', fontsize=12)

# Set labels and titles
ax.set_xticks(x)
ax.set_xticklabels(df['age_groups'], fontsize=15)
ax.set_yticklabels([int(y) for y in ax.get_yticks()], fontsize=15)
ax.set_ylabel('Mortality per 100,000 persons', fontsize=15)

# Add legend
ax.legend(fontsize=15)

# Save figure
plt.savefig('./results/figure_1.png', bbox_inches='tight', dpi=600)


#======================================================================================
# END
#======================================================================================

