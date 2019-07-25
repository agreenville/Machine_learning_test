################################################################################
# R code to resize images using EBImage package's resize function
# Resize images for MLWIC package
# credit: https://github.com/VwakeM/MLWIC/blob/master/ResizeImages.Rmd 
################################################################################

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

pb <- winProgressBar(title="Image resize progress bar", label="0% done",
                     min=0, max=100, initial=0) # progress bar
for(i in 1:nrow(files))
{ 
  img_loc = paste(image_folder,files$file[i], sep="")
  img_crop_loc = paste(image_folder,"resized\\",files$file[i], sep="")
  img = readImage(files = img_loc)
  # EBImage functions to resize and write image.
  img_rez = resize(img, w = 256, h = 256)
  writeImage(x = img_rez, files = img_crop_loc)
  
  # Progess bar
  info <- sprintf("%d%% done", round((i/nrow(files))*100))
  setWinProgressBar(pb, i/(nrow(files))*100, label=info)
}
#Once the loop is exited, close the progress bar window: 
close(pb)


# creates data_info.csv with 0 as species id for all images in the image folder. 
# then may need to convert to Unix line endings using notepad ++
# You should not need to specify the line ending for an existing file
# but for a new file you will want to set Edit > EOL Conversion > UNIX Format in notepad ++
write.table(files, file = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/L1/data_info.csv",
         row.names=FALSE, col.names=FALSE, sep=",", quote=FALSE)

### create image_labels.csv file
### Not needed if data_info.csv is used in L1 folder when you don't know the species in the photos 
# write.table(files, file = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/image_labels.csv",
#             row.names=FALSE, col.names=FALSE, sep=",", quote=FALSE)

