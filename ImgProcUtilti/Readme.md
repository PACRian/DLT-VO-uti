# API docu of `ImgProcUtilti`

Some basic toolkits for handling image imports are documented here, that follow on from another previous personal project. And this repository is not perfect yet.

## `input2struct`

Based on the `struct` object `base`(to provide default key-value pairs) to form a new `strcuct` object which can be updated by the `update_struct`,  used to parse function parameters.

```matlab
mstruct = update_struct(base, update_struct)
```



## `conVideoToImages`

Convert videos to images stored in given directory.

```matlab
s = conVideoToImages(filename, ['range', range, 'savepath', spth, 'percent', percent, 'resize', resize, 'ext', ext, 'fmt', fmt])
```

To see a detailed parameter documentation, see [here](https://github.com/PACRian/DLT-VO-uti/blob/main/ImgProcUtilti/conVideoToImages.m)

The output is a signature to indicate whether it successed or not.



## `refineImages`

Apply some image transformation to process all the images from one directory to another.

```matlab
s = refineImages(filepath, ['range', range, 'resize', resize, 'readInfo', readInfo,'IncludeSubfolder', IncludeSubfoler, 'savepath', spth, 'percent', percent,  'ext', ext, 'fmt', fmt])
```

Detailed codesnap can also be found [here](https://github.com/PACRian/DLT-VO-uti/blob/main/ImgProcUtilti/refineImages.m)

