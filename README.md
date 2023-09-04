# MATLAB createOutputTable Function
This repository contains the MATLAB function `createOutputTable()`. This function takes the results table from the Statistical Parametric Mapping toolbox ([SPM](https://www.fil.ion.ucl.ac.uk/spm/)) and extracts (1) essential data (e.g., p-values, t-values, cluster size, coordinates, and hemisphere) and (2) applies the [mni2atlas](https://de.mathworks.com/matlabcentral/fileexchange/87047-mni2atlas) toolbox to each coordinate. The output is a neat table with all necessary information and brain areas from X different atlases to use for publication.

![Image](https://github.com/m-guseva/B81-Dashboard/assets/63409978/a6d3f431-48bc-4551-be28-945f280a785f)

 
## How to use:
1. Save your SPM output table to a mat file (you can find it under the struct variable `TabDat` that appears when a contrast is loaded in SPM's results pane)
2. run `tbl = createOutputTable('PATH', 'contrastName')`, where:
    - `'PATH'`: Path to SPM's output table (.mat file)
    - `'contrastName'`: Name of contrast

The function will return a structured table `tbl` containing the processed data.
You can run this function for all the contrasts of interest and then concatenate the tables to have one big handy overview e.g. using `all_results = [tbl1; tbl2; tbl3; tbl4]`.

## Dependency:
This function needs the mni2atlas toolbox. Download it [here](https://de.mathworks.com/matlabcentral/fileexchange/87047-mni2atlas) first and add it to your MATLAB path.


## Example Data
You can find an example output file `ExampleContrast.mat` in this repository to test the function's functionality. Simply run `tbl = createOutputTable('ExampleContrast.mat', 'exampleContrast')`




