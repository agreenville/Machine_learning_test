
library(MLWIC)

# setup(python_loc = "C:/ProgramData/Anaconda3", conda_loc = "auto",
#       r_reticulate = TRUE)


# Runing example

classify(path_prefix = "D:/Users/agre6595/Camera_trap_machine_learning/MLWIC_examples/images", # this is the absolute path to the images. 
         data_info = "D:/Users/agre6595/Camera_trap_machine_learning/MLWIC_examples/image_labels.csv", # this is the location of the csv containing image information. It has Unix linebreaks and no headers.
         model_dir = "D:/Users/agre6595/Camera_trap_machine_learning/", # assuming this is where you stored the L1 folder in Step 3 of the instructions: github.com/mikeyEcology/MLWIC/blob/master/README
         python_loc = "C:/ProgramData/Anaconda3/", # the location of Python on your computer. 
         save_predictions = "model_predictions.txt" # this is the default and you should use it unless you have reason otherwise.
)



make_output(output_location = "D:/Users/agre6595/Camera_trap_machine_learning/", # the output csv will be stored on my dekstop
            output_name = "example_results.csv", # the name of the csv I want to create with my output
            model_dir = "D:/Users/agre6595/Camera_trap_machine_learning/", # the location where I stored the L1 folder
            saved_predictions = "model_predictions.txt" # the same name that I used for save_predictions in the classify function (if I didn't use default, I would need to change this).
)


# classify example desert camera trap images, with pre-trained model from paper
# Note there needs to be a file called data_info.csv in the L1 folder, which is the same file
# as image_labels.csv

classify(
          # this is the absolute path to the images.
         path_prefix = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/images/resized", 
         
         # this is the location of the csv containing image information. It has Unix linebreaks and no headers.
         # first coln are filenames and 2nd are 0's if species are unknown
         #data_info = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/image_labels.csv", 
          data_info = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/L1/data_info.csv",
         
         # assuming this is where you stored the L1 folder in Step 3 of the instructions:
         #github.com/mikeyEcology/MLWIC/blob/master/README
         model_dir = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/", 
         
         # the location of Python on your computer. 
         python_loc = "C:/ProgramData/Anaconda3/", 
         
         # this is the default and you should use it unless you have reason otherwise.
         save_predictions = "model_predictions.txt" 
        )

# note that answer coln seems to be the number you supplied in data_info.csv

make_output(
            # the output csv will be stored on my dekstop
            output_location = "D:/Users/agre6595/Camera_trap_machine_learning/", 
  
            # the name of the csv I want to create with my output
            output_name = "DERG_example_results2.csv", 
  
            # the location where I stored the L1 folder
            model_dir = "D:/Users/agre6595/Camera_trap_machine_learning/desert_eg/", 
  
            # the same name that I used for save_predictions in the classify function
            #(if I didn't use default, I would need to change this).
            saved_predictions = "model_predictions.txt" 
            )

