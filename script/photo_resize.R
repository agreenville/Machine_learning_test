# R code to resize images using EBImage package's resize function
# credit: https://github.com/VwakeM/MLWIC/blob/master/ResizeImages.Rmd 

# # Package installation instructions
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("EBImage", version = "3.8")

#load library
library(EBImage)

# folder containing images to be classified. 
image_folder = "D:\\Users\\agre6595\\Camera_trap_machine_learning\\desert_eg\\images\\"

files = as.data.frame(list.files(image_folder))
names(files)[1] = paste("file")
files$id = 0

# resizing files to 256 by 256 px as required by the MLWIC.
# saves resized images in the resized folder under the image folder. 
# need to create the folder called resized, within image folder
for(i in 1:nrow(files))
{ 
  img_loc = paste(image_folder,files$file[i], sep="")
  img_crop_loc = paste(image_folder,"resized\\",files$file[i], sep="")
  img = readImage(files = img_loc)
  # EBImage functions to resize and write image.
  img_rez = resize(img, w = 256, h = 256)
  writeImage(x = img_rez, files = img_crop_loc)
}

# creates data_info.csv with 0 as species id for all images in the image folder. 
# then may need to convert to Unix line endings using notepad ++
write.table(files, file = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/L1/data_info.csv",
         row.names=FALSE, col.names=FALSE, sep=",", quote=FALSE)

# # create image_labels.csv file
write.table(files, file = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/image_labels.csv",
            row.names=FALSE, col.names=FALSE, sep=",", quote=FALSE)
