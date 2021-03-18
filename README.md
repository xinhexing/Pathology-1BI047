# Pathology-1BI047 ImageJ Macros
Two ImageJ macros I used to automate histology frame analysis labwork for my pathology course.

**folder_sort.ijm** sorts your main histology images folder into several smaller folders based on the stain.

**batch_analyze.ijm** can then be used on one of those stain folders to batch process/analyze all images using a specified sequence of filters and functions (specified by our lab compendium, in this case). Configurable variables are max threshold and watershed on/off.