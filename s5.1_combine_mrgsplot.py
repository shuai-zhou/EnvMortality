#======================================================================================
# load libraries
#======================================================================================
from PIL import Image
import matplotlib.pyplot as plt
import matplotlib.lines as mlines

#======================================================================================
# plot cv
#======================================================================================
# Open images
img1  = Image.open('./results/mrgsplot_cv_0_1_pm25_v5.png')
img2  = Image.open('./results/mrgsplot_cv_1_14_pm25_v5.png')
img3  = Image.open('./results/mrgsplot_cv_15_64_pm25_v5.png')
img4  = Image.open('./results/mrgsplot_cv_65_pm25_v5.png')

# 2x2 figure
fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(32, 20))
fig.subplots_adjust(hspace=0.0, wspace=0.0)  # Reduce gaps between images

# Display images without using a loop
ax1.imshow(img1); ax1.axis("off"); ax1.set_title('a)', loc='left', fontsize=26)
ax2.imshow(img2); ax2.axis("off"); ax2.set_title('b)', loc='left', fontsize=26)
ax3.imshow(img3); ax3.axis("off"); ax3.set_title('c)', loc='left', fontsize=26)
ax4.imshow(img4); ax4.axis("off"); ax4.set_title('d)', loc='left', fontsize=26)

# Add text annotations
fig.text(0.29, 0.11, "Temperature", fontsize=22, ha='left', va='bottom')
fig.text(0.68, 0.11, "Temperature", fontsize=22, ha='left', va='bottom')

# Add legend with different line styles
low_pm25 = mlines.Line2D([], [], color='black', marker='o', linestyle='-', markersize=12, markerfacecolor='white', label='PM2.5 = Low')
med_pm25 = mlines.Line2D([], [], color='black', marker='o', linestyle='-', markersize=12, markerfacecolor='black', label='PM2.5 = Medium')
hig_pm25 = mlines.Line2D([], [], color='black', marker='+', linestyle='-', markersize=12, label='PM2.5 = High')
fig.legend(handles=[low_pm25, med_pm25, hig_pm25], loc='lower center', fontsize=22, ncol=3, frameon=False, bbox_to_anchor=(0.52, 0.06))

# Add y-axis title to ax1 and ax3
fig.text(0.13, 0.7, "Mortality per 100,000 people", fontsize=22, rotation=90, va='center')
fig.text(0.13, 0.3, "Mortality per 100,000 people", fontsize=22, rotation=90, va='center')

# Save image
fig.savefig('./results/cv_v5.png', bbox_inches='tight', dpi=300)

#======================================================================================
# plot cr
#======================================================================================
# Open images
img1  = Image.open('./results/mrgsplot_cr_0_1_pm25_v5.png')
img2  = Image.open('./results/mrgsplot_cr_1_14_pm25_v5.png')
img3  = Image.open('./results/mrgsplot_cr_15_64_pm25_v5.png')
img4  = Image.open('./results/mrgsplot_cr_65_pm25_v5.png')

# 2x2 figure
fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(32, 20))
fig.subplots_adjust(hspace=0.0, wspace=0.0)  # Reduce gaps between images

# Display images without using a loop
ax1.imshow(img1); ax1.axis("off"); ax1.set_title('a)', loc='left', fontsize=26)
ax2.imshow(img2); ax2.axis("off"); ax2.set_title('b)', loc='left', fontsize=26)
ax3.imshow(img3); ax3.axis("off"); ax3.set_title('c)', loc='left', fontsize=26)
ax4.imshow(img4); ax4.axis("off"); ax4.set_title('d)', loc='left', fontsize=26)

# Add text annotations
fig.text(0.29, 0.11, "Temperature", fontsize=22, ha='left', va='bottom')
fig.text(0.68, 0.11, "Temperature", fontsize=22, ha='left', va='bottom')

# Add legend with different line styles
low_pm25 = mlines.Line2D([], [], color='black', marker='o', linestyle='-', markersize=12, markerfacecolor='white', label='PM2.5 = Low')
med_pm25 = mlines.Line2D([], [], color='black', marker='o', linestyle='-', markersize=12, markerfacecolor='black', label='PM2.5 = Medium')
hig_pm25 = mlines.Line2D([], [], color='black', marker='+', linestyle='-', markersize=12, label='PM2.5 = High')
fig.legend(handles=[low_pm25, med_pm25, hig_pm25], loc='lower center', fontsize=22, ncol=3, frameon=False, bbox_to_anchor=(0.52, 0.06))

# Add y-axis title to ax1 and ax3
fig.text(0.13, 0.7, "Mortality per 100,000 people", fontsize=22, rotation=90, va='center')
fig.text(0.13, 0.3, "Mortality per 100,000 people", fontsize=22, rotation=90, va='center')

# Save image
fig.savefig('./results/cr_v5.png', bbox_inches='tight', dpi=300)

#======================================================================================
# END
#======================================================================================

