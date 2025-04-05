#======================================================================================
# load libraries
#======================================================================================
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

#======================================================================================
# generate data
#======================================================================================
df = pd.DataFrame({
    "age_groups": ["All-age", "0-1", "1-14", "15-64", "65+"],
    "cr_values": [74.59, 2.04, 0.55, 18.59, 515.32],  # Chronic Respiratory Diseases
    "cv_values": [273.33, 12.62, 0.83, 88.45, 2002.77]  # Cardiovascular Diseases
})
df['cr_values_log'] = np.log(df['cr_values'])
df['cv_values_log'] = np.log(df['cv_values'])
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
ax.bar(x - bar_width/2, df['cr_values'], width=bar_width, color="white", edgecolor="black", label="Chronic Respiratory (CR) Diseases")

# Plot bars for Cardiovascular Diseases
ax.bar(x + bar_width/2, df['cv_values'], width=bar_width, color="darkgray", edgecolor="black", label="Cardiovascular (CV) Diseases")

# Annotate bars with values
for i, v in enumerate(df['cr_values']):
    ax.text(i - bar_width/2, v + 30, f"{v:.2f}", ha='center', fontsize=12)
for i, v in enumerate(df['cv_values']):
    ax.text(i + bar_width/2, v + 30, f"{v:.2f}", ha='center', fontsize=12)

# Set labels and titles
ax.set_xticks(x)
ax.set_xticklabels(df['age_groups'], fontsize=15)
ax.set_yticklabels([int(y) for y in ax.get_yticks()], fontsize=15)
ax.set_ylabel("Mortality per 100,000 people", fontsize=15)

# Add legend
ax.legend(fontsize=15)

# Save figure
plt.savefig('./results/cause_age_mortality.png', bbox_inches='tight', dpi=600)


#======================================================================================
# END
#======================================================================================

